class AddNewColumns < ActiveRecord::Migration[5.2]
  def change
    rename_column :courses, :decription, :description
    rename_column :courses, :url, :ucas_url

    # Courses Table
    add_column :courses, :institute_url, :string
    add_column :courses, :start_date, :string
    add_column :courses, :code, :string

    # Entry Requirements Table
    add_column :entry_requirements, :grade, :string
    add_column :entry_requirements, :info, :string

    # Fees Table
    remove_foreign_key :fees, :costs
    add_column :fees, :fee, :integer
    add_column :fees, :time_period, :string
  end
end
