# == Schema Information
#
# Table name: institutions
#
#  id           :bigint(8)        not null, primary key
#  email        :text
#  name         :string           not null
#  phone_number :string
#  website      :text
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#
# Indexes
#
#  index_institutions_on_name  (name) UNIQUE
#

class Institution < ApplicationRecord
  validates :name, presence: true
  
  has_many :members
  has_many :departments
end
