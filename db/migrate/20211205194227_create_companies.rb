class CreateCompanies < ActiveRecord::Migration[6.1]
  def change
    create_table :companies do |t|
      t.string :name
      t.text :about_company
      t.string :website
      t.string :email
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
