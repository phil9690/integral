module Integral
  # Represents a user post
  class Post < ActiveRecord::Base
    extend FriendlyId
    friendly_id :title, use: :history

    acts_as_taggable

    mount_uploader :image, PostImageUploader

    enum status: [ :draft, :published ]

    # Conditional is hack to check if method exists otherwise causes undefined method error in test env
    self.per_page = 8 if self.respond_to? :per_page

    # Associations
    belongs_to :user

    # Validations
    validates :title, presence: true, length: { minimum: 4, maximum: 70 }
    validates :description, presence: true, length: { minimum: 50, maximum: 200 }
    validates :body, :user, presence: true

    # @return [Array] containing available human readable statuses against there numeric value
    def self.available_statuses
      [
        ['Draft', 0],
        ['Published', 1]
      ]
    end

    private

    def should_generate_new_friendly_id?
      title_changed?
    end
  end
end
