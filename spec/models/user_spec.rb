# == Schema Information
#
# Table name: users
#
#  current_sign_in_at     :datetime
#  current_sign_in_ip     :inet
#  email                  :string           default(""), not null, primary key
#  encrypted_password     :string           default(""), not null
#  last_sign_in_at        :datetime
#  last_sign_in_ip        :inet
#  remember_created_at    :datetime
#  reset_password_sent_at :datetime
#  reset_password_token   :string
#  sign_in_count          :integer          default(0), not null
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  member_id              :bigint(8)
#
# Indexes
#
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_member_id             (member_id)
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#
# Foreign Keys
#
#  fk_rails_...  (member_id => members.id)
#

require 'rails_helper'

RSpec.describe User, type: :model do
  it 'is valid with all valid attributes' do
    user = User.new(email: 'test@test.com', member_id: 1,
                    password: 'password', password_confirmation: 'password')
    expect(user).to be_valid
  end

  it 'is invalid without an email address' do
    user = User.new(email: nil, member_id: 1)
    expect(user).to_not be_valid
  end

  it 'is invalid without a member_id' do
    user = User.new(email: 'test', member_id: nil)
    expect(user).to_not be_valid
  end

  it 'will create a reset token when generate_reset_token called' do
    user = User.new(email: 'test@test.com', member_id: 1,
                    password: 'password', password_confirmation: 'password')
    user.generate_reset_token
    token = user[:reset_password_token]
    token != nil
  end
end
