class CreateJobSeekerSkills < ActiveRecord::Migration[6.1]
  def change
    create_table :job_seeker_skills do |t|
      t.references :skill, null: false, foreign_key: true
      t.references :resume, null: false, foreign_key: true

      t.timestamps
    end
  end
end
