class CreateEducations < ActiveRecord::Migration[6.1]
  def change
    create_table :educations do |t|
      t.string :level_of_education
      t.string :field_of_study
      t.string :school_name
      t.string :country
      t.string :city_or_state
      t.boolean :currently_enrolled
      t.datetime :from
      t.datetime :to

      #t.references :job_seeker, null: false, foreign_key: true
      t.references :resume, null: false, foreign_key: true

      t.timestamps
    end
  end
end
