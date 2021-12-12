class CreateResumes < ActiveRecord::Migration[6.1]
  def change
    create_table :resumes do |t|
      # About me
      t.string :first_name
      t.string :last_name
      t.string :phone_number
      # Location
      t.string :country
      t.string :street_address
      t.string :city_or_state
      # Education
      # t.string :level_of_education
      # t.string :field_of_study
      # t.string :school_name
      # t.string :country
      # t.string :city_or_state
      # t.string :time_period
      # # Work experience
      # t.string :job_title
      # t.string :company
      # t.string :country
      # t.string :city_or_state
      # t.string :time_period
      # t.string :description

      t.references :job_seeker, null: false, foreign_key: true

      t.timestamps
    end
  end
end
