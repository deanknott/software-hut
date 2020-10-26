# == Schema Information
#
# Table name: eligibility_requirements
#
#  id         :bigint(8)        not null, primary key
#  name       :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

FactoryBot.define do
  factory :eligibility_requirement do
    name { "MyString" }
  end
end
