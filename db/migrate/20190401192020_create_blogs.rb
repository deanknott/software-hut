class CreateBlogs < ActiveRecord::Migration[5.2]
  def change
    create_table :blogs do |t|
      t.string :name
      t.references :member, foreign_key: true
      t.references :privacy, foreign_key: true
      t.text :content
      t.string :file
      t.timestamps
    end
  end
end
