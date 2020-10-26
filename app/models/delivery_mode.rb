# == Schema Information
#
# Table name: delivery_modes
#
#  id         :bigint(8)        not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class DeliveryMode < ApplicationRecord
  validates :name, presence: true
  
  has_many :courses
  has_many :stored_searches
end
