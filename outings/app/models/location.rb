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
end
