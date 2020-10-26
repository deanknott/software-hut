# == Schema Information
#
# Table name: roles
#
#  id         :bigint(8)        not null, primary key
#  name       :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_roles_on_name  (name) UNIQUE
#

require 'rails_helper'

RSpec.describe Role, type: :model do
  it 'is valid with all valid attributes' do
    role = Role.new(name: 'test')
    expect(role).to be_valid
  end

  it 'is invalid without a name' do
    role = Role.new(name: nil)
    expect(role).to_not be_valid
  end
end
