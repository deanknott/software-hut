# == Schema Information
#
# Table name: fees
#
#  id              :bigint(8)        not null, primary key
#  fee             :integer          not null
#  time_period     :string
#  course_id       :bigint(8)        not null
#  student_type_id :bigint(8)        not null
#
# Indexes
#
#  course_id        (course_id)
#  student_type_id  (student_type_id)
#
# Foreign Keys
#
#  fk_rails_...  (course_id => courses.id)
#  fk_rails_...  (student_type_id => student_types.id)
#

require 'rails_helper'

RSpec.describe Fee, type: :model do
  it 'is valid with all valid attributes' do
    department = FactoryBot.create(:department, name: 'test', institution_id: 1)
    end_qual = FactoryBot.create(:end_qualification, name: 'test')
    course = FactoryBot.create(:course,code: 'test', name: 'test',
                        department_id: department.id,
                        end_qualification_id: end_qual.id)
    student = FactoryBot.create(:student_type, name: 'test')
    fee = Fee.new(fee: 10, course_id: course.id, student_type_id: student.id)
    expect(fee).to be_valid
  end

  it 'is invalid without a fee' do
    fee = Fee.new(fee: nil, course_id: 1, student_type_id: 1)
    expect(fee).to_not be_valid
  end

  it 'is invalid without a course id' do
    fee = Fee.new(fee: 10, course_id: nil, student_type_id: 1)
    expect(fee).to_not be_valid
  end

  it 'is invalid without a student type id' do
    fee = Fee.new(fee: 10, course_id: 1, student_type_id: nil)
    expect(fee).to_not be_valid
  end
end
