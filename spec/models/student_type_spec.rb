# == Schema Information
#
# Table name: student_types
#
#  id         :bigint(8)        not null, primary key
#  name       :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_student_types_on_name  (name) UNIQUE
#

require 'rails_helper'

RSpec.describe StudentType, type: :model do
  it 'is valid with all valid attributes' do
    student = StudentType.new(name: 'test')
    expect(student).to be_valid
  end

  it 'is invalid without a name' do
    student = StudentType.new(name: nil)
    expect(student).to_not be_valid
  end

end
