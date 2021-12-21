class CreateResumeSkills < ActiveRecord::Migration[6.1]
  def change
    create_table :resume_skills do |t|
      t.references :skill, null: false, foreign_key: true
      t.references :resume, null: false, foreign_key: true

      t.timestamps
    end
  end
end
