# == Schema Information
#
# Table name: costs
#
#  id          :bigint(8)        not null, primary key
#  annual_cost :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

FactoryBot.define do
  factory :cost do
    anual_cost { 1 }
  end
end
