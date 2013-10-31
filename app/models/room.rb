class Room < ActiveRecord::Base
	extend FriendlyId

	mount_uploader :picture, PictureUploader

	validates_presence_of :title
	validates_presence_of :slug
	friendly_id :title, use: [:slugged, :history]

	belongs_to :user
	has_many :reviews, dependent: :destroy
	has_many :reviewed_rooms, through: :reviews, source: :room

	validates_presence_of :title, :location, :description

	scope :most_recent, -> { order('created_at DESC') }

	def complete_name
		"#{title}, #{location}"
	end

	def self.search(query)
		if query.present?
			where(['location ILIKE :query OR title ILIKE :query OR description ILIKE :query',
							query: "%#{query}%"])
		else
			scoped
		end
	end
end