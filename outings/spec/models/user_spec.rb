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

require 'rails_helper'

RSpec.describe User, type: :model do
  let(:org) { Organization.create(name: 'Google')}
  let(:loc) { Location.create(name: 'Chipotle')}
  let(:user) { User.create(name: 'bob', password: '123', phone: "9146935919", organization_id: org.id)}
  let(:user2) { User.create(name: 'Mary', password: '123', phone:"914-693-4922", organization_id: org.id)}
  let(:plan) { Plan.create(location_id: loc.id, user_id: user.id)}

  describe '#phone_digits_only' do
    it 'displays just the digits of a phone number' do
      expect(user2.phone_digits_only).to eq('9146934922')
    end
  end

  describe '#display_phone' do
    it 'displays a properly formatted phone number' do
      expect(user.display_phone).to eq ('(914) 693 - 5919')
    end
  end

end
