class AddPrimaryKeysToTables < ActiveRecord::Migration[5.2]
  def change
    add_column :entry_requirements, :id, :primary_key
  end
end
