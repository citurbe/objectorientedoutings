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
end
