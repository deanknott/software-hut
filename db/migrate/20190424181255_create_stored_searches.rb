class CreateStoredSearches < ActiveRecord::Migration[5.2]
  def change
    create_table :stored_searches do |t|
      t.string :email
      t.string :name
      t.string :institution
      t.integer :length
      t.references :delivery_mode
      t.boolean :full_time
      t.integer :distance
      t.string :location

      t.timestamps
    end
  end
end
