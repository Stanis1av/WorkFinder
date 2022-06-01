class Skill < ApplicationRecord
  extend FriendlyId
  friendly_id :name, use: :slugged

  has_many :resume_skills
  has_many :vacancy_skills

  has_many :resumes, through: :resume_skills
  has_many :vacancies, through: :vacancy_skills
end
