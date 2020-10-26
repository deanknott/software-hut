# == Schema Information
#
# Table name: stored_searches
#
#  id               :bigint(8)        not null, primary key
#  distance         :integer
#  email            :string           not null
#  full_time        :boolean
#  institution      :string
#  length           :integer
#  location         :string
#  name             :string
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  delivery_mode_id :bigint(8)
#
# Indexes
#
#  index_stored_searches_on_delivery_mode_id  (delivery_mode_id)
#

class StoredSearch < ApplicationRecord
  belongs_to :delivery_mode, optional: true

  validates :email, presence: true
end
