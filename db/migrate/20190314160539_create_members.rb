class CreateMembers < ActiveRecord::Migration[5.2]
  def change
    create_table :members do |t|
      t.string :title
      t.string :name
      t.string :job
      t.text :bio
      t.references :institution, foreign_key: true
      t.references :role, foreign_key: true
      t.references :account_privacy, foreign_key: true

      t.timestamps
    end
  end
end
