class User < ApplicationRecord
  # Include default devise modules. Others available are:
  #  :trackable and :omniauthable
  devise :database_authenticatable,
         :registerable,
         :confirmable,
         :recoverable,
         :rememberable,
         :validatable,
         :lockable,
         :timeoutable
end
