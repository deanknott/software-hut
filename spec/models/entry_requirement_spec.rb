# == Schema Information
#
# Table name: entry_requirements
#
#  id                        :bigint(8)        not null, primary key
#  grade                     :string           not null
#  info                      :string
#  course_id                 :bigint(8)        not null
#  incoming_qualification_id :bigint(8)        not null
#
# Indexes
#
#  index_entry_requirements_on_course_id                  (course_id)
#  index_entry_requirements_on_incoming_qualification_id  (incoming_qualification_id)
#
# Foreign Keys
#
#  fk_rails_...  (course_id => courses.id)
#  fk_rails_...  (incoming_qualification_id => incoming_qualifications.id)
#

require 'rails_helper'

RSpec.describe EntryRequirement, type: :model do
  it 'is valid with all valid attributes' do
    department = FactoryBot.create(:department, name: 'test', institution_id: 1)
    end_qual = FactoryBot.create(:end_qualification, name: 'test')
    course = FactoryBot.create(:course,code: 'test', name: 'test',
                        department_id: department.id,
                        end_qualification_id: end_qual.id)
    incoming_qual = FactoryBot.create(:incoming_qualification, name: 'test')
    req = EntryRequirement.new(grade: 'AAA', course_id: course.id,
                               incoming_qualification_id: incoming_qual.id)
    expect(req).to be_valid
  end

  it 'is invalid without a grade' do
    req = EntryRequirement.new(grade: nil, course_id: 1,
                               incoming_qualification_id: 1)
    expect(req).to_not be_valid
  end

  it 'is invalid without a course id' do
    req = EntryRequirement.new(grade: 'AAA', course_id: nil,
                               incoming_qualification_id: 1)
    expect(req).to_not be_valid
  end

  it 'is invalid without an incoming qualifictaion id' do
    req = EntryRequirement.new(grade: 'AAA', course_id: 1,
                               incoming_qualification_id: nil)
    expect(req).to_not be_valid
  end
end
