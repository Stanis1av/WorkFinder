class CreateLocations < ActiveRecord::Migration[6.1]
  def change
    create_table :locations do |t|
      t.string :country_of_residence
      t.string :street_address_residence
      t.string :city_or_state_of_residence
      t.boolean :relocation

      t.references :job_seeker, null: false, foreign_key: true

      t.timestamps
    end
  end
end
