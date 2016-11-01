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
  let!(:user) { User.create(name: 'boB SMith', email: 'email@email', password: '123', password_confirmation: '123',phone: "9146935919", organization_id: org.id)}
  let!(:user2) { User.create(name: 'Mary', password: '123', email: 'email@email', password_confirmation: '123', phone:"914-693-4922", organization_id: org.id)}
  let!(:review1) {Review.create(user: user, location: chipotle, score: 3, comment: Faker::Lorem.sentence)}
  let!(:review2) {Review.create(user: user, location: chipotle, score: 1, comment: Faker::Lorem.sentence)}
  let!(:plan) { Plan.create(location: bagels, organizer: user, timing: Time.now)}
  let!(:outing) { Outing.create(plan: plan, user: user)}



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

    it "returns nil when a user has not reviewed any restaurants" do
      expect(user2.favorite_place).to eq (nil)
    end
  end

  describe '#self.activity' do
    it "returns a list of the datetime when a user left a review or went on an outing" do
      expect(User.activity(user)).to eq([[review1.created_at, 0], [review2.created_at, 1], [plan.timing, 2]])
    end
  end

  describe '#camel_case' do
    it "returns the name of the individual with the first letter of each word capitalized" do
      expect(user.camel_case).to eq("BoB SMith")
    end
  end

  describe "#conflict?" do
    it "returns true if the user has another plan at the same time" do
      expect(user.conflict?(plan.timing)).to eq(true)
    end
    it "returns false if the user has no other plans at the same time" do
      expect(user.conflict?(plan.timing + 3)).to eq(false)
    end
  end

end
