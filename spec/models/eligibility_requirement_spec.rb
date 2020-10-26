# == Schema Information
#
# Table name: eligibility_requirements
#
#  id         :bigint(8)        not null, primary key
#  name       :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'rails_helper'

RSpec.describe EligibilityRequirement, type: :model do
  it 'is valid with all valid attributes' do
    req = EligibilityRequirement.new(name: 'test')
    expect(req).to be_valid
  end

  it 'is invalid without a name' do
    req = EligibilityRequirement.new(name: nil)
    expect(req).to_not be_valid
  end

end
