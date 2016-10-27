# == Schema Information
#
# Table name: plans
#
#  id           :integer          not null, primary key
#  location_id  :integer
#  organizer_id :integer
#  timing       :datetime
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

class Plan < ApplicationRecord
  belongs_to :location
  has_many :outings
  has_many :users, through: :outings
end
