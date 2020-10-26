# == Schema Information
#
# Table name: incoming_qualifications
#
#  id         :bigint(8)        not null, primary key
#  name       :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_incoming_qualifications_on_name  (name) UNIQUE
#

class IncomingQualification < ApplicationRecord
  validates :name, presence: true

  has_many :entry_requirements
  has_many :courses, through: :entry_requirements
end
