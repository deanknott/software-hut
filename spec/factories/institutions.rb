# == Schema Information
#
# Table name: institutions
#
#  id           :bigint(8)        not null, primary key
#  email        :text
#  name         :string           not null
#  phone_number :string
#  website      :text
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#
# Indexes
#
#  index_institutions_on_name  (name) UNIQUE
#

FactoryBot.define do
  factory :institution do
    name { "MyString" }
    website { "MyText" }
    phone_number { "" }
    email { "MyText" }
  end
end
