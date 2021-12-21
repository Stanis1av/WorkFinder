class CreateVacancySkills < ActiveRecord::Migration[6.1]
  def change
    create_table :vacancy_skills do |t|
      t.references :skill, null: false, foreign_key: true
      t.references :vacancy, null: false, foreign_key: true

      t.timestamps
    end
  end
end
