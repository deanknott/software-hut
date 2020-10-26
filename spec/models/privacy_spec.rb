# == Schema Information
#
# Table name: privacies
#
#  id    :bigint(8)        not null, primary key
#  level :string           not null

require 'rails_helper'

RSpec.describe Privacy, type: :model do
  it 'is valid with all valid attributes' do
    privacy = Privacy.new(level: 'test')
    expect(privacy).to be_valid
  end

  it 'is invalid without a level' do
    privacy = Privacy.new(level: nil)
    expect(privacy).to_not be_valid
  end

end
