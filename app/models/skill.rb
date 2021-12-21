class Skill < ApplicationRecord
  has_many :resume_skills
  has_many :vacancy_skills

  has_many :resumes, through: :resume_skills
  has_many :vacancies, through: :vacancy_skills
end
