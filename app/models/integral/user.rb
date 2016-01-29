module Integral
  class User < ActiveRecord::Base
    # Included devise modules. Others available are:
    # :confirmable, :timeoutable, :omniauthable and registerable
    devise :database_authenticatable, :recoverable, :rememberable, :trackable, :validatable, :lockable
  end
end
