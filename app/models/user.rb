# == Schema Information
#
# Table name: users
#
#  current_sign_in_at     :datetime
#  current_sign_in_ip     :inet
#  email                  :string           default(""), not null, primary key
#  encrypted_password     :string           default(""), not null
#  last_sign_in_at        :datetime
#  last_sign_in_ip        :inet
#  remember_created_at    :datetime
#  reset_password_sent_at :datetime
#  reset_password_token   :string
#  sign_in_count          :integer          default(0), not null
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  member_id              :bigint(8)
#
# Indexes
#
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_member_id             (member_id)
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#
# Foreign Keys
#
#  fk_rails_...  (member_id => members.id)
#

class User < ActiveRecord::Base
  validates :email, presence: true
  validates :member_id, presence: true

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  self.primary_key = :email

  belongs_to :member
  accepts_nested_attributes_for :member

  def generate_reset_token
    token = Devise.token_generator.generate(User, :reset_password_token)
    self.reset_password_token = token[0]
    self.reset_password_sent_at = Time.now.utc
    save!
  end
end
