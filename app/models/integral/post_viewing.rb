module Integral
  # Represents when a visitor views a post. Used to keep track of unique view count based on IP address
  class PostViewing < ActiveRecord::Base
    belongs_to :post

    # Adds a post viewing if it does not already exist
    #
    # @param post [Post] object which has been viewed
    # @param ip_address [String] ip_address of the viewer
    #
    # @return [Boolean] whether or not the viewing was successfully added
    def self.add(post, ip_address)
      return false if where(post: post, ip_address: ip_address).exists?

      create!(post: post, ip_address: ip_address)
      true
    end
  end
end
