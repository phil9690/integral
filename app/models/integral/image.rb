module Integral
  # Represents an image uploaded by a user
  class Image < ActiveRecord::Base
    validates :file, presence: true

    validates :title, presence: true, length: { minimum: 5, maximum: 70 }
    validates :description, length: { maximum: 200 }

    mount_uploader :file, ImageUploader

    # @return [String] represents the original size of the image
    def size
      "#{width}x#{height}"
    end
  end
end