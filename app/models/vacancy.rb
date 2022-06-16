class Vacancy < ApplicationRecord
  belongs_to :employer

  has_one_attached :logo
  has_rich_text :description

  has_many :vacancy_skills, dependent: :destroy
  has_many :skills, through: :vacancy_skills

  default_scope { order(created_at: :desc) }

  def logo_thumbnail
    logo.variant(resize: '150x150!').processed
  end

  def skill_list=(skills_string)
    skill_names = skills_string.split(",").collect{|s| s.strip.downcase}.uniq
    new_or_found_skills = skill_names.collect { |name| Skill.find_or_create_by(name: name) }
    self.skills = new_or_found_skills
  end

  # =====|Wicked|===================================

  enum form_steps: {
    basic_details: [:job_title, :company_name, :country, :city_or_state],
    job_details: [:work_experience, :job_type, :schedule_job, :skill_list],
    compensation_details: [:from, :to, :currency, :rate],
    job_description: [:description], #, :image
    contact_details: [:first_name, :last_name, :phone, :email]
  }

  attr_accessor :form_step

  enum work_experiences: {
    # irrelevant: I18n.t('.steps_controllers.vacancy_steps.job_details.irrelevant'),
    # no_experience: I18n.t('.steps_controllers.vacancy_steps.job_details.no_experience'),
    not_required: I18n.t('.steps_controllers.vacancy_steps.job_details.not_required'),
    f1_t3: I18n.t('.steps_controllers.vacancy_steps.job_details.f1_t3'),
    f3_t6: I18n.t('.steps_controllers.vacancy_steps.job_details.f3_t6'),
    more_6: I18n.t('.steps_controllers.vacancy_steps.job_details.more_6')
  }

  enum job_types: {
    full_time: I18n.t('.steps_controllers.vacancy_steps.job_details.full_time'),
    part_time: I18n.t('.steps_controllers.vacancy_steps.job_details.part_time'),
    temporary: I18n.t('.steps_controllers.vacancy_steps.job_details.temporary'),
    contract: I18n.t('.steps_controllers.vacancy_steps.job_details.contract'),
    internship: I18n.t('.steps_controllers.vacancy_steps.job_details.internship'),
    commission: I18n.t('.steps_controllers.vacancy_steps.job_details.commission')
  }

  enum schedules: {
    hour_8: I18n.t('.steps_controllers.vacancy_steps.job_details.hour_8'),
    hour_10: I18n.t('.steps_controllers.vacancy_steps.job_details.hour_10'),
    hour_12: I18n.t('.steps_controllers.vacancy_steps.job_details.hour_12'),
    # weekend_availability: I18n.t('.steps_controllers.vacancy_steps.job_details.weekend_availability'),
    # monday_to_friday: I18n.t('.steps_controllers.vacancy_steps.job_details.monday_to_friday'),
    on_call: I18n.t('.steps_controllers.vacancy_steps.job_details.on_call'),
    # holidays: I18n.t('.steps_controllers.vacancy_steps.job_details.holidays'),
    # day_shift: I18n.t('.steps_controllers.vacancy_steps.job_details.day_shift'),
    # night_shift: I18n.t('.steps_controllers.vacancy_steps.job_details.night_shift'),
    # overtime: I18n.t('.steps_controllers.vacancy_steps.job_details.overtime'),
    other: I18n.t('.steps_controllers.vacancy_steps.job_details.other')
  }

  enum currencies: {
    rub: I18n.t('.steps_controllers.vacancy_steps.compensation_details.rub'),
    usd: I18n.t('.steps_controllers.vacancy_steps.compensation_details.usd'),
    eur: I18n.t('.steps_controllers.vacancy_steps.compensation_details.eur')
  }

  with_options if: -> { required_for_step?(:basic_details) } do
    validates :company_name, presence: true #, length: { minimum: 2, maximum: 30}
    validates :job_title, presence: true #, length: { minimum: 10, maximum: 50}
    validates :country, presence: true
    validates :city_or_state, presence: true
  end

  with_options if: -> { required_for_step?(:job_details) } do
    validates :work_experience, presence: true
    validates :job_type, presence: true
    validates :schedule_job, presence: true
  end

  with_options if: -> { required_for_step?(:compensation_details) } do
    validates :currency, presence: true
    validates :rate, presence: true
  end

  with_options if: -> { required_for_step?(:job_description) } do
    # validates :description, presence: true
    # validates :image
  end

  with_options if: -> { required_for_step?(:contact_details) } do
    validates :first_name, presence: true
    validates :last_name, presence: true
    validates :phone, presence: true
    validates :email, presence: true
  end

  # Checks current step to enable or disable validations appropriately
  def required_for_step?(step)
    # All fields are required if no form step is present
    return true if form_step.nil?

    # All fields from previous steps are required
    ordered_keys = self.class.form_steps.keys.map(&:to_sym)
    !!(ordered_keys.index(step) <= ordered_keys.index(form_step))
  end

  # ================================================
end
