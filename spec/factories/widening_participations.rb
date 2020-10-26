# == Schema Information
#
# Table name: widening_participations
#
#  id         :bigint(8)        not null, primary key
#  wp_type    :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

FactoryBot.define do
  factory :widening_participation do
    type { "" }
  end
end
