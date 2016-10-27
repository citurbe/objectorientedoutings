# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  name            :string
#  email           :string
#  phone           :integer
#  user_name       :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  password_digest :string
#

class User < ApplicationRecord
  has_secure_password
  validates :email, presence: true
  validates :email, uniqueness: true
  validates :password, presence: true
  validates :organization_id, presence: true

  belongs_to :organization
  has_many :outings
  has_many :plans, through: :outings
  has_many :locations, through: :plans
  has_many :reviews

end
