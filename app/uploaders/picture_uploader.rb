class PictureUploader < CarrierWave::Uploader::Base
  include CarrierWave::RMagick
  storage :file

  def store_dir
    "uploads/picture"
  end

  def extension_white_list
    %w(jpg jpeg gif png)
  end

  version :norm do
    process resize_to_fit: [100, 100]
  end

  version :big do
    process :resize_to_fit => [700,700]
  end
end