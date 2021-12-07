class CreateVacancies < ActiveRecord::Migration[6.1]
  def change
    create_table :vacancies do |t|

      t.timestamps
    end
  end
end
