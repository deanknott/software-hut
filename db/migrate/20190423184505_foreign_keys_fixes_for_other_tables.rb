class ForeignKeysFixesForOtherTables < ActiveRecord::Migration[5.2]
  def change
    add_foreign_key :courses, :delivery_modes, column: :delivery_mode_id
    add_foreign_key :courses_eligibilities, :courses, column: :course_id
    add_foreign_key :courses_eligibilities, :eligibility_requirements, column: :eligibility_requirement_id
    add_foreign_key :courses_wps, :courses, column: :course_id
    add_foreign_key :courses_wps, :widening_participations, column: :widening_participation_id
    add_foreign_key :entry_requirements, :courses, column: :course_id
    add_foreign_key :entry_requirements, :incoming_qualifications, column: :incoming_qualification_id
  end
end
