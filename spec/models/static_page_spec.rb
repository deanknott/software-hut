# == Schema Information
#
# Table name: static_pages
#
#  id          :bigint(8)        not null, primary key
#  contents    :text             not null
#  custom_file :string
#  name        :string           not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

require 'rails_helper'

RSpec.describe StaticPage, type: :model do
  it 'is valid with all valid attributes' do
    static = StaticPage.new(name: 'test', contents: 'test')
    expect(static).to be_valid
  end

  it 'is invalid without a name' do
    static = StaticPage.new(name: nil, contents: 'test')
    expect(static).to_not be_valid
  end

  it 'is invalid without contents' do
    static = StaticPage.new(name: 'test', contents: nil)
    expect(static).to_not be_valid
  end

  it 'should return name when to_param is called' do
    static = StaticPage.new(name: 'test', contents: 'testing')
    name = static.to_param
    name == 'test'
  end
end
