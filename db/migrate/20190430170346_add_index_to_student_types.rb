class AddIndexToStudentTypes < ActiveRecord::Migration[5.2]
  def change
    add_index :student_types, :name, unique: true
  end
end
