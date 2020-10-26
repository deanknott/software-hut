# frozen_string_literal: true

# Author - Team 34: Luke Peacock
# Updated - 10.05.19

# This uploader service uses CarrierWave to upload a file
# It is used by blogs.
class BlogFileUploader < CarrierWave::Uploader::Base
  # Include RMagick or MiniMagick support:
  # include CarrierWave::RMagick
  include CarrierWave::MiniMagick

  # Storage type
  storage :file

  # Maintain current file unless deleted
  configure do |config|
    config.remove_previously_stored_files_after_update = false
  end

  # Upload directory
  # Uses the blog ID to store the files
  def store_dir
    Rails.root.join("uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}")
  end

  # cache directory for temporary storage
  def cache_dir
    "#{Rails.root}/tmp/uploads"
  end

  # White list of extensions which are allowed to be uploaded.
  def extension_whitelist
    %w[jpg jpeg gif png pdf doc docx]
  end

end
