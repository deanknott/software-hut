# == Schema Information
#
# Table name: wps
#
#  id         :bigint(8)        not null, primary key
#  wp_type    :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Wp < ApplicationRecord
  validates :wp_type, presence: true

  has_and_belongs_to_many :courses
end
