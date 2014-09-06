class EventLogoUploader < CarrierWave::Uploader::Base
  include CarrierWave::RMagick

  # Choose what kind of storage to use for this uploader:
  storage :file
  # storage :fog

  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  process :resize_to_limit => [150, 150]

  version :thumb do
    process :resize_to_limit => [50,50]
  end

  def extension_white_list
    %w(jpg jpeg gif png)
  end
end
