module Integral
  # Handles uploading user avatars
  class AvatarUploader < ImageUploader
    include CarrierWave::MiniMagick

    # Provide a default URL as a default if there hasn't been a file uploaded
    def default_url
      ActionController::Base.helpers.asset_path("default_avatar.jpg")
    end

    # Create different versions of your uploaded files
    version :thumb do
      process :resize_to_fit => [50, 50]
    end

    # Override the filename of the uploaded files
    def filename
      model.name.parameterize if original_filename
    end
  end
end
