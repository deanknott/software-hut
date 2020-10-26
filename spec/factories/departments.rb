# == Schema Information
#
# Table name: departments
#
#  id             :bigint(8)        not null, primary key
#  email          :string
#  name           :string           not null
#  phone_number   :string
#  url            :string
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  institution_id :bigint(8)
#
# Indexes
#
#  index_departments_on_institution_id  (institution_id)
#
# Foreign Keys
#
#  fk_rails_...  (institution_id => institutions.id)
#

FactoryBot.define do
  factory :department do
    name { "MyString" }
    phone_number { "MyString" }
    email { "MyString" }
    url { "MyString" }
    institution { nil }
  end
end
