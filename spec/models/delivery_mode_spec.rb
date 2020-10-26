# == Schema Information
#
# Table name: delivery_modes
#
#  id         :bigint(8)        not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'rails_helper'

RSpec.describe DeliveryMode, type: :model do
  it 'is valid with all valid attributes' do
    mode = DeliveryMode.new(name: 'test')
    expect(mode).to be_valid
  end

  it 'is invalid without a name' do
    mode = DeliveryMode.new(name: nil)
    expect(mode).not_to be_valid
  end
end
