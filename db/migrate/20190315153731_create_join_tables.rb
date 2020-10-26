class CreateJoinTables < ActiveRecord::Migration[5.2]
  def change
    create_table :entry_requirements, id: false do |t|
      t.belongs_to :course, index: true
      t.belongs_to :incoming_qualification, index: true
    end

    create_table :fees, id: false do |t|
      t.belongs_to :course, index: true
      t.belongs_to :cost, index: true
      t.belongs_to :student_type, index: true
    end

    create_table :courses_eligibilities, id: false do |t|
      t.belongs_to :course, index: true
      t.belongs_to :eligibility_requirement, index: true
    end

    create_table :courses_wps, id: false do |t|
      t.belongs_to :course, index: true
      t.belongs_to :widening_participation, index: true
    end
  end
end
