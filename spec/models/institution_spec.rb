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

require 'rails_helper'

RSpec.describe Institution, type: :model do
  it 'is valid with all valid attributes' do
    institution = Institution.new(name: 'test')
    expect(institution).to be_valid
  end

  it 'is invalid without a name' do
    institution = Institution.new(name: nil)
    expect(institution).to_not be_valid
  end
end
