module Integral
  # Handles the has many relationship between User and Role
  class RoleAssignment < ActiveRecord::Base
    belongs_to :user
    belongs_to :role
  end
end

