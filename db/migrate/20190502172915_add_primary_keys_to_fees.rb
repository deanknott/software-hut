class AddPrimaryKeysToFees < ActiveRecord::Migration[5.2]
  def change
    add_column :fees, :id, :primary_key
  end
end
