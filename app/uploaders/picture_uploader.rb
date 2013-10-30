# encoding: utf-8

class PictureUploader < CarrierWave::Uploader::Base
  include CarrierWave::RMagick

  storage :file

  # Diretório onde os arquivos serão armazendos
  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  # Redimensona a imagem para ficar no tamanho de no máximo 500x500,
  # mantendo o aspecto e cortando se necessário
  process :resize_to_fill => [500, 500]

  # Provide a default URL as a default if there hasn't been a file uploaded:
  # def default_url
  #   # For Rails 3.1+ asset pipeline compatibility:
  #   # ActionController::Base.helpers.asset_path("fallback/" + [version_name, "default.png"].compact.join('_'))
  #
  #   "/images/fallback/" + [version_name, "default.png"].compact.join('_')
  # end

  # Process files as they are uploaded:
  # process :scale => [200, 300]
  #
  # def scale(width, height)
  #   # do something
  # end

  # Dimensões do thumbnail
  version :thumb do
    process :resize_to_fill => [100, 100]
  end

  # Informa os formatos permitidos
  def extension_white_list
    %w(jpg jpeg gif png)
  end

  # Override the filename of the uploaded files:
  # Avoid using model.id or version_name here, see uploader/store.rb for details.
  # def filename
  #   "something.jpg" if original_filename
  # end
end