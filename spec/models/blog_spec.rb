# == Schema Information
#
# Table name: blogs
#
#  id         :bigint(8)        not null, primary key
#  content    :text             not null
#  file       :string
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  member_id  :bigint(8)        not null
#  privacy_id :bigint(8)        not null
#
# Indexes
#
#  index_blogs_on_member_id   (member_id)
#  index_blogs_on_privacy_id  (privacy_id)
#
# Foreign Keys
#
#  fk_rails_...  (member_id => members.id)
#  fk_rails_...  (privacy_id => privacies.id)
#

require 'rails_helper'

RSpec.describe Blog, type: :model do
  it 'is valid with all valid attributes' do
    blog = Blog.new(name: 'test', content: 'test',
                    member_id: 1, privacy_id: 1)
    expect(blog).to be_valid
  end

  it 'is invalid without a name' do
    blog = Blog.new(name: nil, content: 'test',
                    member_id: 1, privacy_id: 1)
    expect(blog).to_not be_valid
  end

  it 'is invalid without contents' do
    blog = Blog.new(name: 'test', content: nil,
                    member_id: 1, privacy_id: 1)
    expect(blog).to_not be_valid
  end

  it 'is invalid without a member_id' do
    blog = Blog.new(name: 'test', content: 'test',
                    member_id: nil, privacy_id: 1)
    expect(blog).to_not be_valid
  end

  it 'is invalid without a privacy_id' do
    blog = Blog.new(name: 'test', content: 'test',
                    member_id: 1, privacy_id: nil)
    expect(blog).to_not be_valid
  end
end
