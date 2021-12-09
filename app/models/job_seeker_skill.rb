class JobSeekerSkill < ApplicationRecord
  belongs_to :skill
  belongs_to :resume
end
