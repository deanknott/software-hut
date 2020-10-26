# == Schema Information
#
# Table name: blogs
#
#  id         :bigint(8)        not null, primary key
#  content    :text             not null
#  file       :string
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  member_id  :bigint(8)        not null
#  privacy_id :bigint(8)        not null
#
# Indexes
#
#  index_blogs_on_member_id   (member_id)
#  index_blogs_on_privacy_id  (privacy_id)
#
# Foreign Keys
#
#  fk_rails_...  (member_id => members.id)
#  fk_rails_...  (privacy_id => privacies.id)
#

FactoryBot.define do
  factory :blog do
    name { "Blog Name" }
    content {'Blog Content'}
    file {nil}
    created_at {Time.now}
    updated_at {Time.now}
    member {nil}
    privacy {nil}
  end
end
