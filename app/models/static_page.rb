# == Schema Information
#
# Table name: static_pages
#
#  id          :bigint(8)        not null, primary key
#  contents    :text             not null
#  custom_file :string
#  name        :string           not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class StaticPage < ApplicationRecord
  mount_uploader :custom_file, StaticPageCustomFileUploader

  validates :contents, presence: true
  validates :name, presence: true

  def to_param
    name
  end
end
