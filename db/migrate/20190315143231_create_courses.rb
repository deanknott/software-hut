class CreateCourses < ActiveRecord::Migration[5.2]
  def change
    create_table :courses do |t|
      t.string :name
      t.references :department, foreign_key: true
      t.text :decription
      t.references :delivery_mode
      t.boolean :full_time
      t.string :location
      t.integer :length
      t.string :url
      t.text :notes
      t.references :end_qualification

      t.timestamps
    end
  end
end
