# == Schema Information
#
# Table name: wps
#
#  id         :bigint(8)        not null, primary key
#  wp_type    :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'rails_helper'

RSpec.describe Wp, type: :model do
  it 'is valid with all valid attributes' do
    wp = Wp.new(wp_type: 'test')
    expect(wp).to be_valid
  end

  it 'is invalid without a wp_type' do
    wp = Wp.new(wp_type: nil)
    expect(wp).to_not be_valid
  end
end
