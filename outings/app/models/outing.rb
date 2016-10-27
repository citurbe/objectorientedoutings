# == Schema Information
#
# Table name: outings
#
#  id         :integer          not null, primary key
#  plan_id    :integer
#  user_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Outing < ApplicationRecord
end
