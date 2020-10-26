# == Schema Information
#
# Table name: account_privacies
#
#  id            :bigint(8)        not null, primary key
#  privacy_level :string           not null
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

class AccountPrivacy < ApplicationRecord
  validates :privacy_level, presence: true

  
  has_many :members
end
