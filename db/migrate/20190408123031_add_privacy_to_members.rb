class AddPrivacyToMembers < ActiveRecord::Migration[5.2]
  def change
    add_reference :members, :email_privacy, index: true
    add_reference :members, :bio_privacy, index: true
    add_reference :members, :job_privacy, index: true
  end
end
