class CreateVacancies < ActiveRecord::Migration[6.1]
  def change
    create_table :vacancies do |t|
      t.string :job_title
      t.string :company_name
      t.string :country
      t.string :location
      t.boolean :remote
      t.string :type_of_job
      t.string :salary
      t.string :description

      t.references :employer, null: false, foreign_key: true

      t.timestamps
    end
  end
end
