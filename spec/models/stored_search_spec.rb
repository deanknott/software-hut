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

require 'rails_helper'

RSpec.describe StoredSearch, type: :model do
  it 'is valid with all valid attributes' do
    search = StoredSearch.new(email: 'test')
    expect(search).to be_valid
  end

  it 'is invalid without an email' do
    search = StoredSearch.new(email: nil)
    expect(search).to_not be_valid
  end
end
