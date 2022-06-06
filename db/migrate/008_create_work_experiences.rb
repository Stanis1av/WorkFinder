class CreateWorkExperiences < ActiveRecord::Migration[6.1]
  def change
    create_table :work_experiences do |t|
      t.string :job_title
      t.text :description
      t.string :company
      t.string :country_of_work
      t.string :city_or_state_of_work
      t.boolean :i_currently_work_here
      t.datetime :from
      t.datetime :to

      # t.references :job_seeker, null: false, foreign_key: true
      t.references :resume, null: false, foreign_key: true

      t.timestamps
    end
  end
end
