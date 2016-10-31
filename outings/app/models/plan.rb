# == Schema Information
#
# Table name: plans
#
#  id              :integer          not null, primary key
#  location_id     :integer
#  organizer_id    :integer
#  timing          :datetime
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  organization_id :integer
#

class Plan < ApplicationRecord
  belongs_to :location
  belongs_to :organization
  has_many :outings
  belongs_to :organizer, class_name: 'User', foreign_key: 'organizer_id'
  has_many :users, through: :outings

  validates :location_id, presence: true
  validates :timing, presence: true

  def time_to_go
    self.users.each do |user|
      if user.name != self.organizer.name
        message = "#{self.organizer.name} is ready to go to #{self.location.name}. Time to head out!"
        PlanMailer.time_to_go(user, message).deliver
      end
    end
  end

  def summary(user = nil)
    "#{self.current?(user)} going to #{self.location.name} with #{self.users.count - 1} other people on #{self.day} at #{self.timing.strftime('%r')}"
  end

  def current?(user)
    if !user
      if self.organizer.name
        "#{self.organizer.camel_case} is"
      else
        "#{self.organizer.email} is"
      end
    else "I am "
    end
  end

  def day
    self.timing.strftime('%a, %b %d')
  end

  def front_page?(current_user)
    self.timing.strftime('%j').to_i >= Time.now.strftime('%j').to_i &&
       self.timing.strftime('%j').to_i <= Time.now.strftime('%j').to_i + 3 &&
       (!current_user.plans.include?(self) || current_user == nil)
  end

  def get_loc(params)
    if params[:plan][:location_id] != "" && !params[:plan][:location_id] != nil
      Location.find(params[:plan][:location_id]).id
    else
      make_loc(params).id
    end
  end

  def make_loc(params)
    location = Location.new(name: params[:plan][:location])
    if location.save
      location
    else
      redirect_to new_plan_path
    end
  end
end
