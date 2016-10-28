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
  validates :email, :password, :password_confirmation, :organization_id, presence: true
  validates :email, uniqueness: true
  validate :phone_number_format

  belongs_to :organization
  has_many :outings
  has_many :plans, through: :outings
  has_many :locations, through: :plans
  has_many :reviews


  def phone_number_format
  nums = self.phone.scan(/([0-9])/).flatten.join
  unless nums.length == 10 || nums.length == 0
    self.errors[:phone] << "Phone number must be 10 digits exactly!"
  end
end

end
