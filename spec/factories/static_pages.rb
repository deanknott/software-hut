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

FactoryBot.define do
  factory :static_page do
    name { "MyString" }
    contents { "MyText" }
  end
end
