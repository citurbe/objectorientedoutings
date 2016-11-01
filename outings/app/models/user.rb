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

  def self.activity(user)
    #1 - We grab all the reviews and plans and put zip them together in a multidimensional array
    #2 - We sort all that activity by created_at asc then map out the created_at dates
    #3 - We use each with object to form a hash counting the total of the hash at each entry
    #4 - This gives us a collection with the amount of activity each time it is added to

    (user.reviews.map(&:created_at) + user.plans.map(&:timing)).sort.each_with_object({}){|time, hash| hash[time] = hash.keys.count}.to_a

  end

  def phone_digits_only
    nums = self.phone.scan(/([0-9])/).flatten.join
  end

  def display_phone
    if phone != nil
      digits = self.phone_digits_only
      formatted = "(#{digits[0..2]}) #{digits[3..5]} - #{digits[6..9]}"
    end
  end

  def phone_number_format
    if self.phone != nil
      nums = self.phone.scan(/([0-9])/).flatten.join
      unless nums.length == 10
        self.errors[:phone] << "Phone number must be 10 digits exactly!"
      end
    end
  end

  def favorite_place
    all_reviews = self.reviews
    sorted_reviews = all_reviews.sort_by {|review| review.score}
    best_review = sorted_reviews.last
    if best_review != nil
      return best_review.location
    else
      return nil
    end
  end

  def camel_case
    if name != nil
      name = self.name.split.map do |word|
        word = word.split("")
        word.first.capitalize!
        word.join('')
      end
      name.join(' ')
    else
      return nil
    end
  end

  def conflict?(timing)
    self.plans.map(&:timing).include?(timing)
  end
  #
  # def review_chart_data
  #   self.reviews.group(:score).count.map do |key,val|
  #     ["Rated #{key}",val]
  #   end.compact
  # end
  #
  # def plan_chart_data
  #   self.plans.group_by_day(:timing).count.map do |key,val|
  #     [key,val] if key >= 5.days.ago
  #   end.compact
  # end

  def line_chart_library
    {
      library:{
        backgroundColor:'#EDEDED',
        crosshair: {
          trigger: 'focus',
          orientation: 'both',
          focused: { color: '#3bc', opacity: 0.8 }
        },
        vAxis:{
          textPosition: 'none'
        }
      }
    }
  end
end
