class JobSeeker < ApplicationRecord
  after_create :create_job_seeker_location

  belongs_to :user
  has_one :resume, dependent: :destroy
  has_one :location, dependent: :destroy

  has_one_attached :avatar

  accepts_nested_attributes_for :location

  def avatar_thumbnail
    avatar.variant(resize: '150x150!').processed
  end
  private

  def create_job_seeker_location
    Location.create(job_seeker_id: id)
  end
end
