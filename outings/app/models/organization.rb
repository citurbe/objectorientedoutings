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

  def top_five
    Organization.first.users.map(&:reviews).sort_by(&:count).reverse.first(5).map do |review|
      review.first ? review.first.user.camel_case : "Empty spot"
    end
  end

  def locations

  end

end
