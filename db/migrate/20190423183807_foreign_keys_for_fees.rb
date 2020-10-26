class ForeignKeysForFees < ActiveRecord::Migration[5.2]
  def change
    add_foreign_key :fees, :costs, column: :cost_id
    add_foreign_key :fees, :courses, column: :course_id
    add_foreign_key :fees, :student_types, column: :student_type_id
  end
end
