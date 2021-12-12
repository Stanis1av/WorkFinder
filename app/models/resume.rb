class Resume < ApplicationRecord
  belongs_to :job_seeker

  has_many :job_seeker_skills, dependent: :destroy
  has_many :skills, through: :job_seeker_skills

  default_scope { order(created_at: :desc) }

  def skill_list=(skills_string)
    skill_names = skills_string.split(",").collect{|s| s.strip.downcase}.uniq
    new_or_found_skills = skill_names.collect { |name| Skill.find_or_create_by(name: name) }
    self.skills = new_or_found_skills
  end
end
