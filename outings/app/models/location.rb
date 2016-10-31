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

  def time_of_day

    return nil if self.plans == []
    morning = 0
    afternoon = 0
    night = 0
    self.plans.each do |plan|
      morning += 1 if plan.timing.hour < 12
      afternoon += 1 if plan.timing.hour > 12 && plan.timing.hour < 18
      night += 1 if plan.timing.hour > 18
    end
    return "This seems to be a morning place" if morning > afternoon && morning > night
    return "This seems to be an afternoon place" if afternoon > morning && afternoon > night
    return "This seems to be an evening place" if night > morning && night > afternoon
    return "People go here at all hours"
    end

  def reviews_chart_data
    self.reviews.group(:score).count.map do |key,val|
      ["Rated #{key}",val]
    end
  end

  def pie_chart_library
    {
      library:{
        pieSliceText: 'label',
        width:600,
        tooltip:{
          text:'value',
          ignoreBounds: true
        },
        legend: 'none'
      }
    }
  end

  def column_chart_library
    {
      library:{
        width:600,
        vAxis:{
          gridlines: {count:0}
        }
      }
    }
  end

end
