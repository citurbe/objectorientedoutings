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
  has_many :locations, through: :plans

  validates :name, presence: true
  validates :name, uniqueness: true

  def top_users
    self.users.map(&:reviews).sort_by(&:count).reverse.first(5).map do |review|
      review.first ? review.first.user.camel_case : "Empty spot"
    end
  end

  def top_locations
    plan_data.merge(review_data){|key, rev, plan| rev + plan}.keys.first(5)
  end

  def plan_data
    self.locations.each_with_object({}) do |loc, hash|
      if !hash[loc.name] then hash[loc.name] = 0 end
      hash[loc.name] += 1
    end
  end

  def review_data
    viable_reviews.each_with_object({}) do |loc, hash|
      name = Location.find(loc.first.location_id).name
      if !hash[name] then hash[name] = 0 end
      hash[name] += 1
    end
  end

  def viable_reviews
    self.locations.map(&:reviews).select{|rev| !rev.empty? &&
      day(rev.first.updated_at) >= day(Time.now) - 7}
  end

  def day(updated)
    updated.strftime('%j').to_i
  end
end
