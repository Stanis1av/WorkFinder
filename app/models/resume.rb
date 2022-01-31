class Resume < ApplicationRecord
  belongs_to :job_seeker

  default_scope { order(created_at: :desc) }
end
