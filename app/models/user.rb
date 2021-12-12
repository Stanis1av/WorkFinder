class User < ApplicationRecord
  after_save :create_a_profile_based_on_the_role

  has_one :job_seeker, dependent: :destroy
  has_one :company, dependent: :destroy

  # Include default devise modules. Others available are:
  # :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :validatable

  private

  def create_a_profile_based_on_the_role
    # if job_seeker? == true
    #   JobSeeker.create(user_id: id)
    # elsif company? == true
    #   Company.create(user_id: id)
    # end
    #
    if role == 'jobseeker'
      JobSeeker.create(user_id: id)
    elsif role == 'company'
      Company.create(user_id: id)
    end
  end
end
