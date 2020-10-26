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

class Blog < ApplicationRecord
  mount_uploader :file, BlogFileUploader

  validates :content, presence: true
  validates :name, presence: true
  validates :member_id, presence: true
  validates :privacy_id, presence: true

  belongs_to :member
  belongs_to :privacy
end
