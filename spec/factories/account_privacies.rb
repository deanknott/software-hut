# == Schema Information
#
# Table name: account_privacies
#
#  id            :bigint(8)        not null, primary key
#  privacy_level :string           not null
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

FactoryBot.define do
  factory :account_privacy do
    privacy_level { "MyString" }
  end
end
