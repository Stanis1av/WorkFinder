class Skill < ApplicationRecord
  has_many :job_seeker_skills
  has_many :resumes, through: :job_seeker_skills
end
