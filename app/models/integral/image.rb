module Integral
  # Represents an image uploaded by a user
  class Image < ActiveRecord::Base
    # Soft-deletion
    acts_as_paranoid

    validates :file, presence: true
    validates :title, presence: true, length: { minimum: 5, maximum: 50 }
    validates :description, length: { maximum: 160 }

    mount_uploader :file, ImageUploader

    # @return [String] represents the original size of the image
    def size
      "#{width}x#{height}"
    end
  end
end
