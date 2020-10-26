# == Schema Information
#
# Table name: privacies
#
#  id    :bigint(8)        not null, primary key
#  level :string           not null
#

class Privacy < ApplicationRecord
  validates :level, presence: true

  has_many :blog
  has_many :member
end
