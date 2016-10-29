# == Schema Information
#
# Table name: locations
#
#  id         :integer          not null, primary key
#  name       :string
#  address    :string
#  score      :float
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Location < ApplicationRecord
  has_many :plans
  has_many :reviews

  validates :name, uniqueness: true
  validates :name, presence: true

  def display_score
    return 0 if self.reviews == []
    reviews = self.reviews.map {|revs| revs.score}
    num = 0
    reviews.each {|rev| num += rev}
    num.to_f/reviews.size
  end

  def self.random_loc
    random_loc = Location.all.sample
  end

  def self.highest_rated
    locations = Location.all.sort_by {|loc| loc.display_score}
    locations.first
  end

  def number_of_plans
    self.plans.count
  end

  def self.most_popular
    locations = Location.all.sort_by {|loc| loc.number_of_plans}
    locations.first
  end

end
