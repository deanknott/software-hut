# == Schema Information
#
# Table name: members
#
#  id                 :bigint(8)        not null, primary key
#  bio                :text
#  job                :string
#  name               :string           not null
#  title              :string
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  account_privacy_id :bigint(8)        not null
#  bio_privacy_id     :bigint(8)        not null
#  email_privacy_id   :bigint(8)        not null
#  institution_id     :bigint(8)        not null
#  job_privacy_id     :bigint(8)        not null
#  role_id            :bigint(8)        not null
#
# Indexes
#
#  index_members_on_account_privacy_id  (account_privacy_id)
#  index_members_on_bio_privacy_id      (bio_privacy_id)
#  index_members_on_email_privacy_id    (email_privacy_id)
#  index_members_on_institution_id      (institution_id)
#  index_members_on_job_privacy_id      (job_privacy_id)
#  index_members_on_role_id             (role_id)
#
# Foreign Keys
#
#  fk_rails_...  (account_privacy_id => account_privacies.id)
#  fk_rails_...  (institution_id => institutions.id)
#  fk_rails_...  (role_id => roles.id)
#

class Member < ApplicationRecord
  validates :name, presence: true
  validates :account_privacy_id, presence: true
  validates :bio_privacy_id, presence: true
  validates :email_privacy_id, presence: true
  validates :institution_id, presence: true
  validates :job_privacy_id, presence: true
  validates :role_id, presence: true

  belongs_to :institution
  belongs_to :role
  belongs_to :account_privacy

  belongs_to :email_privacy, :class_name => 'Privacy'
  belongs_to :bio_privacy, :class_name => 'Privacy'
  belongs_to :job_privacy, :class_name => 'Privacy'

  has_many :blog
  has_many :privacies
  has_one :user

end
