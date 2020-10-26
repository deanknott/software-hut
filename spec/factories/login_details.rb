# == Schema Information
#
# Table name: login_details
#
#  email      :string
#  password   :string
#  salt       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  member_id  :bigint(8)
#
# Indexes
#
#  index_login_details_on_member_id  (member_id)
#
# Foreign Keys
#
#  fk_rails_...  (member_id => members.id)
#

FactoryBot.define do
  factory :login_detail do
    email { "MyString" }
    password { "MyString" }
    member_id { nil }
  end
end
