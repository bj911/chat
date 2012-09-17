class ImageUploader < CarrierWave::Uploader::Base
  include CarrierWave::RMagick
  storage :file

  def store_dir
    "uploads/avatar/#{model.id}"
  end

  def extension_white_list
    %w(jpg jpeg gif png)
  end

  version :small do
    process :resize_to_fit => [150,150]
  end

  version :big do
    process :resize_to_fit => [800,800]
  end
end