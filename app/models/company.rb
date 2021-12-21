class Company < ApplicationRecord
  belongs_to :user
  has_many :vacancies, dependent: :destroy
end
