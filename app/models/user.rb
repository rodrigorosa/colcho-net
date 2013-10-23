class User < ActiveRecord::Base
	EMAIL_REGEXP = /\A[^@]+@([^@\.]+\.)+[^@\.]+\z/

	has_many :rooms

	validates_presence_of :email, :full_name, :location
	validates_length_of :bio, minimum: 30, allow_blank: false
	validates_uniqueness_of :email
	validates_format_of :email, with: EMAIL_REGEXP

	has_secure_password

	scope :confirmed, -> { where.not(confirmed_at: nil) }

	def self.authenticate(email, password)
		user = confirmed.where(email: email).try(:first)
		if user.present?
			user.authenticate(password)
		end
	end

	before_create do |user|
		user.confirmation_token = SecureRandom.urlsafe_base64
	end

	def confirm!
		return if confirmed?

		self.confirmed_at = Time.current
		self.confirmation_token = ''
		save!
	end

	def confirmed?
		confirmed_at.present?
	end

	private
	def email_format 
		errors.add(:email, :invalid) unless email.match(EMAIL_REGEXP)
	end
end