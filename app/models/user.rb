class User < ApplicationRecord
  before_validation :role_checking
  after_create :create_a_profile_based_on_the_role

  has_one :job_seeker, dependent: :destroy
  has_one :company, dependent: :destroy

  devise :database_authenticatable,
         :registerable,
         :confirmable,
         :recoverable,
         :rememberable,
         :validatable,
         :lockable,
         :timeoutable,
         :omniauthable, omniauth_providers: [:facebook, :google_oauth2]

  # validate :password_complexity

  # def password_complexity
  #   if password.present? and not password.match(/(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])/)
  #     errors.add :password, " должен включать в себя как минимум одну строчную букву, одну заглавную букву и одну цифру"
  #   end
  # end

  def self.from_omniauth(auth)
    find_or_create_by(provider: auth.provider, uid: auth.uid) do |user|
      user.email = auth.info.email
      user.password = Devise.friendly_token[0, 20]
    user.skip_confirmation!
    end
  end

  def self.new_with_session(params, session)
    super.tap do |user|
      if data = session["devise.facebook_data"] && session["devise.facebook_data"]["extra"]["raw_info"]
        user.email = data["email"] if user.email.blank?
      end
    end
  end

  def role_checking
    if role.blank?
      errors.add(:base, 'Выберите роль пользователя')
    elsif role != 'job_seeker' && role != 'company'
      errors.add(:base, 'Выберите корректную роль!')
      return false
    end
  end

  def create_a_profile_based_on_the_role
    if role == 'job_seeker'
      JobSeeker.create(user_id: id)
    elsif role == 'company'
      Company.create(user_id: id)
    end
  end
end
