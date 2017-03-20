module Integral
  # Handles uploading images
  class ImageUploader < CarrierWave::Uploader::Base
    include ::CarrierWave::Backgrounder::Delay
    include CarrierWave::MiniMagick
    include CarrierWave::ImageOptimizer

    # Process images in the background
    process optimize: [{ quality: Integral.configuration.image_compression_quality }]
    process :resize_to_limit => Integral.configuration.editor_image_size_limit

    # Override the directory where uploaded files will be stored.
    def store_dir
      "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
    end

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

    # Create different versions of your uploaded files:
    # version :thumb do
    #   process :resize_to_fit => [50, 50]
    # end

    # Extension white list
    def extension_white_list
      %w(jpg jpeg gif png)
    end

    # Override the filename of the uploaded files
    def filename
      "#{model.title.parameterize}.#{file.extension}" if original_filename
    end
  end
end
