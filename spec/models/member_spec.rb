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

require 'rails_helper'

RSpec.describe Member, type: :model do

  it 'is valid with all valid attributes' do
    member = Member.new(name: 'test', account_privacy_id: 1,
                        bio_privacy_id: 1, email_privacy_id: 1,
                        job_privacy_id: 1, institution_id: 1,
                        role_id: 1)
    expect(member).to be_valid
  end

  it 'is invalid without a name' do
    member = Member.new(name: nil, account_privacy_id: 1,
                        bio_privacy_id: 1, email_privacy_id: 1,
                        job_privacy_id: 1, institution_id: 1,
                        role_id: 1)
    expect(member).to_not be_valid
  end

  it 'is invalid without an account privacyy id' do
    member = Member.new(name: 'test', account_privacy_id: nil,
                        bio_privacy_id: 1, email_privacy_id: 1,
                        job_privacy_id: 1, institution_id: 1,
                        role_id: 1)
    expect(member).to_not be_valid
  end

  it 'is invalid without a bio privacy id' do
    member = Member.new(name: 'test', account_privacy_id: 1,
                        bio_privacy_id: nil, email_privacy_id: 1,
                        job_privacy_id: 1, institution_id: 1,
                        role_id: 1)
    expect(member).to_not be_valid
  end

  it 'is invalid without an email privacy id' do
    member = Member.new(name: 'test', account_privacy_id: 1,
                        bio_privacy_id: 1, email_privacy_id: nil,
                        job_privacy_id: 1, institution_id: 1,
                        role_id: 1)
    expect(member).to_not be_valid
  end

  it 'is invalid without a job privcay id' do
    member = Member.new(name: 'test', account_privacy_id: 1,
                        bio_privacy_id: 1, email_privacy_id: 1,
                        job_privacy_id: nil, institution_id: 1,
                        role_id: 1)
    expect(member).to_not be_valid
  end

  it 'is invalid without an institution id' do
    member = Member.new(name: 'test', account_privacy_id: 1,
                        bio_privacy_id: 1, email_privacy_id: 1,
                        job_privacy_id: 1, institution_id: nil,
                        role_id: 1)
    expect(member).to_not be_valid
  end
  it 'is invalid without a role id' do
    member = Member.new(name: 'test', account_privacy_id: 1,
                        bio_privacy_id: 1, email_privacy_id: 1,
                        job_privacy_id: 1, institution_id: 1,
                        role_id: nil)
    expect(member).to_not be_valid
  end
end
