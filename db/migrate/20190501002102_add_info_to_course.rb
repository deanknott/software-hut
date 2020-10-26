class AddInfoToCourse < ActiveRecord::Migration[5.2]
  def change
    add_column :courses, :entry_requirements_info, :string
    add_column :courses, :fees_info, :string
  end
end
