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
  validates :user_id, uniqueness: true
end
