class JobSeeker < ApplicationRecord
  belongs_to :user
  has_many :resumes, dependent: :destroy
end
