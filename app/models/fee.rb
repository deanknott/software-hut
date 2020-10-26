# == Schema Information
#
# Table name: fees
#
#  id              :bigint(8)        not null, primary key
#  fee             :integer          not null
#  time_period     :string
#  course_id       :bigint(8)        not null
#  student_type_id :bigint(8)        not null
#
# Indexes
#
#  course_id        (course_id)
#  student_type_id  (student_type_id)
#
# Foreign Keys
#
#  fk_rails_...  (course_id => courses.id)
#  fk_rails_...  (student_type_id => student_types.id)
#

class Fee < ApplicationRecord
  validates :fee, presence: true
  validates :course_id, presence: true
  validates :student_type_id, presence: true

  belongs_to :course
  belongs_to :student_type
end
