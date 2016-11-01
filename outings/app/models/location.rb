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
  has_many :users, through: :plans
  has_many :reviews

  validates :name, uniqueness: true
  validates :name, presence: true

  def display_score
    if reviews.length != 0
      reviews.collect(&:score).sum.to_i.to_f/reviews.length
    else
      "No reviews"
    end
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

    return "Busy in the morning" if morning > afternoon && morning > night
    return "Busy in the afternoon" if afternoon > morning && afternoon > night
    return "Busy in the evening" if night > morning && night > afternoon
    return "Always busy"
  end

  # def time_chart_data
  #   byebug
  #   self.plans.each_with_object({}) do |plan, hash|
  #     hash[plan.id] = plan.timing
  #   end
  #   byebug
  # end

  def self.review_data(loc)
    loc.reviews.group(:score).count.map do |key,val|
      [key,val]
    end
  end

  # def reviews_chart_data
  #   self.reviews.group(:score).count.map do |key,val|
  #     [key,val]
  #   end
  # end
  #
  # def pie_chart_library
  #   {
  #     library:{
  #       pieSliceText: 'label',
  #       width:600,
  #       tooltip:{
  #         text:'value',
  #         ignoreBounds: true
  #       },
  #       legend: 'none'
  #     }
  #   }
  # end

  def column_chart_library
    {
      library:{
        width:500,
        crosshair: {
          trigger: 'focus',
          orientation: 'both',
          focused: { color: '#3bc', opacity: 0.8 }
        }
      }
    }
  end

end
