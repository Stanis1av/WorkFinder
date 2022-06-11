class Resume < ApplicationRecord
  belongs_to :job_seeker

  has_one_attached :avatar

  has_many :work_experiences, dependent: :destroy
  has_many :educations, dependent: :destroy
  has_many :resume_skills, dependent: :destroy

  accepts_nested_attributes_for :work_experiences, allow_destroy: true, reject_if: :all_blank
  accepts_nested_attributes_for :educations, allow_destroy: true, reject_if: :all_blank

  has_many :skills, through: :resume_skills

  has_rich_text :summary

  default_scope { order(created_at: :desc) }

  def avatar_thumbnail
    avatar.variant(resize: '150x150!').processed
  end

  # def response
  #   Date.parse(super)
  # end

  # def response=(value)
  #   value = Date.new(value[1], value[2], value[3]) if value.is_a?(Hash)

  #   super(value.to_s)
  # end

  def skill_list=(skills_string)
    skill_names = skills_string.split(",").collect{|s| s.strip.downcase}.uniq
    new_or_found_skills = skill_names.collect { |name| Skill.find_or_create_by(name: name) }
    self.skills = new_or_found_skills
  end

end
