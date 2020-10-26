class RemoveCostIdFromFees < ActiveRecord::Migration[5.2]
  def change
    remove_column :fees, :cost_id
  end
end
