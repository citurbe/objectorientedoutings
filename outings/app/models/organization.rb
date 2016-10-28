# == Schema Information
#
# Table name: organizations
#
#  id         :integer          not null, primary key
#  name       :string
#  admin_id   :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Organization < ApplicationRecord
  has_many :users
  has_many :plans

  validates :name, presence: true
  validates :name, uniqueness: true

end
