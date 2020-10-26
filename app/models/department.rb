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

class Department < ApplicationRecord
  validates :name, presence: true
  validates :institution_id, presence: true

  belongs_to :institution
  has_many :courses
end
