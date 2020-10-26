class DropsCostsTable < ActiveRecord::Migration[5.2]
  def change
    drop_table :costs
  end
end
