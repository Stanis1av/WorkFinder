class Vacancy < ApplicationRecord
  belongs_to :company

  has_many :vacancy_skills, dependent: :destroy
  has_many :skills, through: :vacancy_skills

  default_scope { order(created_at: :desc) }

  def skill_list=(skills_string)
    skill_names = skills_string.split(",").collect{|s| s.strip.downcase}.uniq
    new_or_found_skills = skill_names.collect { |name| Skill.find_or_create_by(name: name) }
    self.skills = new_or_found_skills
  end
end
