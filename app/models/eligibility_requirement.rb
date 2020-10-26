# == Schema Information
#
# Table name: eligibility_requirements
#
#  id         :bigint(8)        not null, primary key
#  name       :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class EligibilityRequirement < ApplicationRecord
  validates :name, presence: true

  has_and_belongs_to_many :courses
end
