module Integral
  # User model used to represent a authenticated user
  class User < ActiveRecord::Base
    # mount_uploader :avatar, AvatarUploader

    # Included devise modules. Others available are:
    # :confirmable, :timeoutable, :omniauthable, registerable and lockable
    devise :database_authenticatable, :recoverable, :rememberable, :trackable, :validatable

    validates :name, :email, presence: true
    validates :name, length: { minimum: 3, maximum: 25 }
  end
end

