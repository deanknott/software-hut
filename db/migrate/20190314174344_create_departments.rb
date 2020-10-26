class CreateDepartments < ActiveRecord::Migration[5.2]
  def change
    create_table :departments do |t|
      t.string :name
      t.string :phone_number
      t.string :email
      t.string :url
      t.references :institution, foreign_key: true

      t.timestamps
    end
  end
end
