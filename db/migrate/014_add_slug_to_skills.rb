class AddSlugToSkills < ActiveRecord::Migration[6.1]
  def change
    add_column :skills, :slug, :string
    add_index :skills, :slug, unique: true
  end
end
