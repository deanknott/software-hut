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

FactoryBot.define do
  factory :member do
    title { "MyString" }
    name { "MyString" }
    job { "MyString" }
    bio { "MyText" }
    institution { nil }
    role { nil }
    account_privacy { nil }
  end
end
