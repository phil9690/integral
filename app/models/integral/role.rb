module Integral
  # Represents levels of authorization
  class Role < ActiveRecord::Base
    has_many :role_assignments
    has_many :users, :through => :role_assignments

    validates :name, presence: true
  end
end

