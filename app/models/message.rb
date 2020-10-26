class Message
  include ActiveModel::Model
  attr_accessor :name, :email, :return_address, :subject, :body
  validates :name, :email, :return_address, :subject, :body, presence: true
end
