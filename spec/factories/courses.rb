# == Schema Information
#
# Table name: courses
#
#  id                      :bigint(8)        not null, primary key
#  code                    :string           not null
#  description             :text
#  entry_requirements_info :string
#  fees_info               :string
#  full_time               :boolean
#  institute_url           :string
#  length                  :integer
#  location                :string
#  name                    :string           not null
#  notes                   :text
#  start_date              :string
#  ucas_url                :string
#  created_at              :datetime         not null
#  updated_at              :datetime         not null
#  delivery_mode_id        :bigint(8)
#  department_id           :bigint(8)
#  end_qualification_id    :bigint(8)
#
# Indexes
#
#  index_courses_on_delivery_mode_id      (delivery_mode_id)
#  index_courses_on_department_id         (department_id)
#  index_courses_on_end_qualification_id  (end_qualification_id)
#
# Foreign Keys
#
#  fk_rails_...  (delivery_mode_id => delivery_modes.id)
#  fk_rails_...  (department_id => departments.id)
#

FactoryBot.define do
  factory :course do
    name { "MyString" }
    department { nil }
    description { "MyText" }
    delivery_mode { nil }
    full_time { false }
    location { "" }
    length { 1 }
    ucas_url { "MyString" }
    notes { "MyText" }
  end
end
