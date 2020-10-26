class CreateEligibilityRequirements < ActiveRecord::Migration[5.2]
  def change
    create_table :eligibility_requirements do |t|
      t.string :name

      t.timestamps
    end
  end
end
