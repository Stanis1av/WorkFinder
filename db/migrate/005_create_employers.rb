class CreateEmployers < ActiveRecord::Migration[6.1]
  def change
    create_table :employers do |t|
      t.string :name
      t.text :about_employer
      t.string :website
      t.string :email

      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
