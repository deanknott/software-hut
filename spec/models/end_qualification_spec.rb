# == Schema Information
#
# Table name: end_qualifications
#
#  id         :bigint(8)        not null, primary key
#  name       :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_end_qualifications_on_name  (name) UNIQUE
#

require 'rails_helper'

RSpec.describe EndQualification, type: :model do
  it 'is valid with all valid attributes' do
    qual = EndQualification.new(name: 'test')
    expect(qual).to be_valid
  end

  it 'is invalid without a fee' do
    qual = EndQualification.new(name: nil)
    expect(qual).to_not be_valid
  end
end
