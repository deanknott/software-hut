# == Schema Information
#
# Table name: entry_requirements
#
#  id                        :bigint(8)        not null, primary key
#  grade                     :string           not null
#  info                      :string
#  course_id                 :bigint(8)        not null
#  incoming_qualification_id :bigint(8)        not null
#
# Indexes
#
#  index_entry_requirements_on_course_id                  (course_id)
#  index_entry_requirements_on_incoming_qualification_id  (incoming_qualification_id)
#
# Foreign Keys
#
#  fk_rails_...  (course_id => courses.id)
#  fk_rails_...  (incoming_qualification_id => incoming_qualifications.id)
#

class EntryRequirement < ApplicationRecord
  validates :grade, presence: true
  validates :course_id, presence: true
  validates :incoming_qualification_id, presence: true

  belongs_to :course
  belongs_to :incoming_qualification
end
