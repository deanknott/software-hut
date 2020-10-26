# == Schema Information
#
# Table name: departments
#
#  id             :bigint(8)        not null, primary key
#  email          :string
#  name           :string           not null
#  phone_number   :string
#  url            :string
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  institution_id :bigint(8)
#
# Indexes
#
#  index_departments_on_institution_id  (institution_id)
#
# Foreign Keys
#
#  fk_rails_...  (institution_id => institutions.id)
#

require 'rails_helper'

RSpec.describe Department, type: :model do
  it 'is valid with all valid attributes' do
    dep = Department.new(name: 'test', institution_id: 1)
    expect(dep).to be_valid
  end

  it 'is invalid without a name' do
    dep = Department.new(name: nil, institution_id: 1)
    expect(dep).not_to be_valid
  end

  it 'is invalid without an institution id' do
    dep = Department.new(name: 'test', institution_id: nil)
    expect(dep).not_to be_valid
  end
end
