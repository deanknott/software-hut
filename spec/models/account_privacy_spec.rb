# == Schema Information
#
# Table name: account_privacies
#
#  id            :bigint(8)        not null, primary key
#  privacy_level :string           not null
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

require 'rails_helper'

RSpec.describe AccountPrivacy, type: :model do
  it 'is valid with all valid attributes' do
    expect(AccountPrivacy.new(privacy_level:" 'test'")).to be_valid
  end

  it 'is invalid without a privacy level' do
    privacy = AccountPrivacy.new(privacy_level: nil)
    expect(privacy).not_to be_valid
  end

end
