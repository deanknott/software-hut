# == Schema Information
#
# Table name: courses_wps
#
#  course_id :bigint(8)
#  wp_id     :bigint(8)
#
# Indexes
#
#  index_courses_wps_on_course_id  (course_id)
#  index_courses_wps_on_wp_id      (wp_id)
#
# Foreign Keys
#
#  fk_rails_...  (course_id => courses.id)
#  fk_rails_...  (wp_id => wps.id)
#

class CoursesWp < ActiveRecord::Base
  validates :course_id, presence: true
  validates :wp_id, presence: true

  belongs_to :course
  belongs_to :wp
end
