class AddUniquesToTables < ActiveRecord::Migration[5.2]
  def change
    add_index :end_qualifications, :name, unique: true
    add_index :incoming_qualifications, :name, unique: true
    add_index :institutions, :name, unique: true
    add_index :roles, :name, unique: true
  end
end
