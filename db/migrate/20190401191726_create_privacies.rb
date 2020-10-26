class CreatePrivacies < ActiveRecord::Migration[5.2]
  def change
    create_table :privacies do |t|
      t.string :level
    end
  end
end
