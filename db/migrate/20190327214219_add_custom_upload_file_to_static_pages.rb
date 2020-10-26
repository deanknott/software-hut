class AddCustomUploadFileToStaticPages < ActiveRecord::Migration[5.2]
  def change
    add_column :static_pages, :custom_file, :string #adds custom_file column to static_pages table, stored as string (but not really?)
  end
end
