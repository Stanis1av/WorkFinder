class CreateVacancies < ActiveRecord::Migration[6.1]
  def change
    create_table :vacancies do |t|
      t.string :job_title
      t.string :company_name
      t.string :country
      t.string :city_or_state

      t.string :work_experience
      t.string :job_type
      t.string :schedule_job

      t.string :from
      t.string :to
      t.string :currency
      t.string :rate

      # t.text :description
      # t.string :images

      t.string :first_name
      t.string :last_name
      t.string :phone
      t.string :email

      t.references :employer, null: false, foreign_key: true

      t.timestamps
    end
  end
end
