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
    user_plans.merge(user_reviews){|key, rev, plan| rev + plan}.sort_by{|k, v| v}.reverse.map(&:first).first(5)
  end

  def user_plans
    self.users.map(&:plans).each_with_object({}) do |plan, hash|
      name = self.users[hash.length].camel_case
      if plan.present?
        if !hash[name] then hash[name] = 0 end
        hash[name] += plan.count
      else
        hash[name] = 0
      end
    end
  end

  def user_reviews
    self.users.map(&:reviews).each_with_object({}) do |review, hash|
      if review.present?
        name = User.find(review.first.user_id).camel_case
        if !hash[name] then hash[name] = 0 end
        hash[name] += review.count
      else
        hash[User.find(hash.length + 1).camel_case] = 0
      end
    end
  end

  def top_locations
    plan_data.merge(review_data){|key, rev, plan| rev + plan}.sort_by{|k, v| v}.reverse.map(&:first).first(5)
  end

  def plan_data
    self.locations.each_with_object({}) do |loc, hash|
      if !hash[loc.name] then hash[loc.name] = 0 end
      hash[loc.name] += 1
    end
  end

  def review_data
    viable_reviews.each_with_object({}) do |review, hash|
      if review.present?
        name = Location.find(review.first.location_id).name
        if !hash[name] then hash[name] = 0 end
        hash[name] += review.count
      else
        hash[Location.find(hash.length + 1).name] = 0
      end
  #    byebug
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
