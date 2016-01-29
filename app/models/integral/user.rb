module Integral
  class User < ActiveRecord::Base
    # Included devise modules. Others available are:
    # :confirmable, :timeoutable, :omniauthable, registerable and lockable
    devise :database_authenticatable, :recoverable, :rememberable, :trackable, :validatable
  end
end
