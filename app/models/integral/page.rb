module Integral
  # Represents a public viewable page
  class Page < ActiveRecord::Base
    acts_as_paranoid # Soft-deletion
    acts_as_listable # Listable Item

    # Validates format of a path
    # Examples:
    # Good:
    # /foo, /foo/bar, /123/456
    # Bad:
    # //, foo, /foo bar, /foo?y=123, /foo$
    PATH_REGEX = /\A\/[\/.a-zA-Z0-9-]+\z/

    enum status: [ :draft, :published ]

    # Validations
    validates :title, presence: true, length: { minimum: 5, maximum: 50 }
    validates :path, presence: true, length: { maximum: 100 }
    validates :path, uniqueness: { case_sensitive: false }
    validates_format_of :path, :with => PATH_REGEX
    validates :description, presence: true, length: { maximum: 160 }
    validate :validate_path_is_not_black_listed

    # Callbacks
    after_save :reload_routes

    # Searches for pages where title is like specified query
    def self.search(search)
      where("lower(title) LIKE ?", "%#{search.downcase}%")
    end

    # @return [Hash] the instance as a list item
    def to_list_item
      {
        id: id,
        title: title,
        # subtitle: '',
        description: description,
        # TODO: Add images to pages
        # image: image.url,
        url: "#{Rails.application.routes.default_url_options[:host]}#{self.path}"
      }
    end

    # @return [Hash] listable options to be used within a RecordSelector widget
    def self.listable_options
      {
        record_title: I18n.t('integral.backend.record_selector.pages.record'),
        selector_path: Engine.routes.url_helpers.backend_pages_path,
        selector_title: I18n.t('integral.backend.record_selector.pages.title')
      }
    end

    # @return [Array] contains available template label and key pairs
    def self.available_templates
      templates = [:default]
      templates.concat Integral.configuration.additional_page_templates

      available_templates = []
      templates.each do |template|
        available_templates << [I18n.t("integral.backend.pages.templates.#{template}"), template]
      end

      available_templates
    end

    private

    # @return [Array] containing available human readable statuses against there numeric value
    def self.available_statuses
      [
        ['Draft', 0],
        ['Published', 1]
      ]
    end

    def validate_path_is_not_black_listed
      valid = true

      Integral.configuration.black_listed_paths.each do |black_listed_path|
        if self.path&.starts_with?(black_listed_path)
          valid = false
          errors.add(:path, 'Invalid path')
          break
        end
      end

      return valid
    end

    def reload_routes
      Integral::PageRouter.reload
    end
  end
end
