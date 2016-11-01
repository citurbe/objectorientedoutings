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
    users.each_with_object({}) do |act, hash|
      hash[act.id] = User.activity(act).count
    end.sort_by {|k,v| v}.reverse.first(5)
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
