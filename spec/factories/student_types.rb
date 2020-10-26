# == Schema Information
#
# Table name: student_types
#
#  id         :bigint(8)        not null, primary key
#  name       :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_student_types_on_name  (name) UNIQUE
#

FactoryBot.define do
  factory :student_type do
    name { "MyString" }
  end
end
