class Skill < ApplicationRecord
  has_many :resume_skills

  has_many :resumes, through: :resume_skills
end
