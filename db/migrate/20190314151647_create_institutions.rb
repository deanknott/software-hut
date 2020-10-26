class CreateInstitutions < ActiveRecord::Migration[5.2]
  def change
    create_table :institutions do |t|
      t.string :name
      t.text :website
      t.string :phone_number
      t.text :email

      t.timestamps
    end
  end
end
