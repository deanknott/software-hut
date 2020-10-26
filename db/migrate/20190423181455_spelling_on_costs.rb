class SpellingOnCosts < ActiveRecord::Migration[5.2]
  def change
    rename_column :costs, :anual_cost, :annual_cost
  end
end
