# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  name            :string
#  email           :string
#  phone           :string
#  user_name       :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  password_digest :string
#  organization_id :integer
#

class User < ApplicationRecord
  has_secure_password
  validates :email, :organization_id, presence: true
  validates :email, uniqueness: true
  validate :phone_number_format
  validates :password, :password_confirmation, presence: true, on: :create

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

  def camel_case
    name = self.name.split.map do |word|
      word = word.split("")
      word.first.capitalize!
      word.join('')
    end
    name.join(' ')
  end

  def conflict?(timing)
    self.plans.map(&:timing).include?(timing)
  end
end
