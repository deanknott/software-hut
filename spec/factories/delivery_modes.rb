# == Schema Information
#
# Table name: delivery_modes
#
#  id         :bigint(8)        not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

FactoryBot.define do
  factory :delivery_mode do
    name { "MyString" }
  end
end
