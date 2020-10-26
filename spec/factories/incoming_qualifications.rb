# == Schema Information
#
# Table name: incoming_qualifications
#
#  id         :bigint(8)        not null, primary key
#  name       :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_incoming_qualifications_on_name  (name) UNIQUE
#

FactoryBot.define do
  factory :incoming_qualification do
    name { "MyString" }
  end
end
