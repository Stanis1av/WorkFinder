class Company < ApplicationRecord
  belongs_to :user
  has_many :vacancies, dependent: :destroy

  has_one_attached :logo

  def logo_thumbnail
    logo.variant(resize: '150x150!').processed
  end
end
