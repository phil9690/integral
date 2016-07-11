module Integral
  # Handles uploading post featured image
  class PostImageUploader < ImageUploader
    include CarrierWave::MiniMagick

    # Provide a default URL as a default if there hasn't been a file uploaded
    def default_url
      ActionController::Base.helpers.asset_path("integral/defaults/post_image.jpg")
    end
  end
end
