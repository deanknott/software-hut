class CreateAccountPrivacies < ActiveRecord::Migration[5.2]
  def change
    create_table :account_privacies do |t|
      t.string :privacy_level

      t.timestamps
    end
  end
end
