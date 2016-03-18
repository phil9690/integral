module Integral
  # Represents a public viewable page
  class Page < ActiveRecord::Base
    # Validates format of a path
    # Examples:
    # Good:
    # /foo, /foo/bar, /123/456
    # Bad:
    # //, foo, /foo bar, /foo?y=123, /foo$
    PATH_REGEX = /\A\/[\/.a-zA-Z0-9-]+\z/

    # Validations
    validates :title, presence: true, length: { minimum: 5, maximum: 70 }
    validates :path, presence: true, length: { maximum: 100 }
    validates :path, uniqueness: { case_sensitive: false }
    validates_format_of :path, :with => PATH_REGEX
    validates :description, length: { maximum: 200 }
    validate :validate_path_is_not_black_listed

    private

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
  end
end
