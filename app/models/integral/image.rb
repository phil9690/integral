module Integral
  # Represents an image uploaded by a user
  class Image < ActiveRecord::Base
    # Soft-deletion
    acts_as_paranoid

    validates :file, presence: true
    validates :title, presence: true, length: { minimum: 5, maximum: 50 }
    validates :description, length: { maximum: 160 }

    mount_uploader :file, ImageUploader
    process_in_background :file

    # Scopes
    scope :search, -> (query) { where("lower(title) LIKE ?", "%#{query.downcase}%") }

    # @return [String] represents the original size of the image
    def size
      "#{width}x#{height}"
    end

    # @return [Hash] the instance as a list item
    def to_list_item
      {
        id: id,
        title: title,
        subtitle: description,
        description: description,
        image: file.url,
      }
    end

    # @return [Hash] listable options to be used within a RecordSelector widget
    def self.listable_options
      {
        record_title: I18n.t('integral.backend.record_selector.images.record'),
        selector_path: Engine.routes.url_helpers.backend_images_path,
        selector_title: I18n.t('integral.backend.record_selector.images.title')
      }
    end
  end
end
