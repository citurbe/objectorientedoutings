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
  let(:chipotle) { Location.create(name: 'Chipotle')}
  let(:bagels) {Location.create(name: 'The Bagel Place')}
  let(:user) { User.create(name: 'bob', email: 'email@email', password: '123', password_confirmation: '123',phone: "9146935919", organization_id: org.id)}
  let(:user2) { User.create(name: 'Mary', password: '123', email: 'email@email', password_confirmation: '123', phone:"914-693-4922", organization_id: org.id)}
  let(:plan) { Plan.create(location_id: bagels.id, user_id: user.id)}



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

  describe '#favorite_place' do
    it "returns a user's highest-rated location" do
      Review.create(score: 5, user_id: user.id, location_id: chipotle.id)
      Review.create(score: 1, user_id: user.id, location_id: bagels.id)
      expect(user.favorite_place.name).to eq ('Chipotle')
    end
  end

end
