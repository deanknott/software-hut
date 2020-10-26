# == Schema Information
#
# Table name: courses
#
#  id                      :bigint(8)        not null, primary key
#  code                    :string           not null
#  description             :text
#  entry_requirements_info :string
#  fees_info               :string
#  full_time               :boolean
#  institute_url           :string
#  length                  :integer
#  location                :string
#  name                    :string           not null
#  notes                   :text
#  start_date              :string
#  ucas_url                :string
#  created_at              :datetime         not null
#  updated_at              :datetime         not null
#  delivery_mode_id        :bigint(8)
#  department_id           :bigint(8)
#  end_qualification_id    :bigint(8)
#
# Indexes
#
#  index_courses_on_delivery_mode_id      (delivery_mode_id)
#  index_courses_on_department_id         (department_id)
#  index_courses_on_end_qualification_id  (end_qualification_id)
#
# Foreign Keys
#
#  fk_rails_...  (delivery_mode_id => delivery_modes.id)
#  fk_rails_...  (department_id => departments.id)
#

require 'rails_helper'

RSpec.describe Course, type: :model do
  it 'is valid with all valid attributes' do
    department = FactoryBot.create(:department, name: 'test', institution_id: 1)
    end_qual = FactoryBot.create(:end_qualification, name: 'test')
    course = Course.new(code: 'test', name: 'test',
                        department_id: department.id,
                        end_qualification_id: end_qual.id)
    expect(course).to be_valid
  end

  it 'is invalid without a name' do
    course = Course.new(code: 'test', name: nil,
                        department_id: 1, end_qualification_id: 1)
    expect(course).not_to be_valid
  end

  it 'is invalid without a code' do
    course = Course.new(code: nil, name: 'test',
                        department_id: 1, end_qualification_id: 1)
    expect(course).not_to be_valid
  end

  it 'is invalid without a department_id' do
    course = Course.new(code: 'test', name: 'test',
                        department_id: nil, end_qualification_id: 1)
    expect(course).not_to be_valid
  end

  it 'is invalid without a delivery_mode_id' do
    course = Course.new(code: 'test', name: 'test',
                        department_id: 1, end_qualification_id: nil)
    expect(course).not_to be_valid
  end
end
