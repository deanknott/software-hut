class RenameCoursesWpsColumn < ActiveRecord::Migration[5.2]
  def change
    rename_column :courses_wps, :widening_participation_id, :wp_id
  end
end
