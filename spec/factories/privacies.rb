# == Schema Information
#
# Table name: privacies
#
#  id    :bigint(8)        not null, primary key
#  level :string           not null
#

FactoryBot.define do
  factory :privacy do
    level { "MyString" }
  end
end
