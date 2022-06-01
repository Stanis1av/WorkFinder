class Resume < ApplicationRecord
  belongs_to :job_seeker

  has_one_attached :avatar

  has_many :resume_skills, dependent: :destroy
  has_many :skills, through: :resume_skills

  default_scope { order(created_at: :desc) }

  def avatar_thumbnail
    avatar.variant(resize: '150x150!').processed
  end

  def skill_list=(skills_string)
    skill_names = skills_string.split(",").collect{|s| s.strip.downcase}.uniq
    new_or_found_skills = skill_names.collect { |name| Skill.find_or_create_by(name: name) }
    self.skills = new_or_found_skills
  end
end
