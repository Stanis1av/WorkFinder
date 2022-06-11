class User < ApplicationRecord
  before_validation :role_checking
  after_create :create_a_profile_based_on_the_role

  has_one :job_seeker, dependent: :destroy
  has_one :employer, dependent: :destroy

  # Include default devise modules. Others available are:
  # :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :validatable

  private

  def role_checking
    if role.blank?
      errors.add(:base, 'Выберите роль пользователя')
    elsif role != 'job_seeker' && role != 'employer'
      errors.add(:base, 'Выберите корректную роль!')
      return false
    end
  end

  def create_a_profile_based_on_the_role
    if role == 'job_seeker'
      JobSeeker.create(user_id: id)
    elsif role == 'employer'
      # Company.create(user_id: id)
      Employer.create(user_id: id)
    end
  end

  has_one_attached :avatar do |attachable|
    attachable.variant :avatar_thumbnail, resize_to_limit: [150, 150] if attachable.attached?
  end
end
