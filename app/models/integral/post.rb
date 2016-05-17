module Integral
  # Represents a user post
  class Post < ActiveRecord::Base
    extend FriendlyId
    friendly_id :title, use: :history

    acts_as_taggable

    # acts_as_commentable

    self.per_page = 8

    # Associations
    belongs_to :user

    # Validations
    validates :title, presence: true, length: { minimum: 4, maximum: 70 }
    validates :description, presence: true, length: { minimum: 50, maximum: 200 }
    validates :body, :user, presence: true

    private

    def should_generate_new_friendly_id?
      title_changed?
    end
  end
end
