require 'rails_helper'

RSpec.describe Organization, type: :model do
  let!(:org) { Organization.create(name: 'Google')}
  let!(:user1) { User.create(name: 'bob', email: 'bob@email', password: '123', password_confirmation: '123', organization_id: org.id)}
  let!(:user2) { User.create(name: 'steve', email: 'steve@email', password: '123', password_confirmation: '123', organization_id: org.id)}
  let!(:user3) { User.create(name: 'mary', email: 'mary@email', password: '123', password_confirmation: '123', organization_id: org.id)}
  let!(:user4) { User.create(name: 'jill', email: 'jill@email', password: '123', password_confirmation: '123', organization_id: org.id)}
  let!(:user5) { User.create(name: 'janet', email: 'janet@email', password: '123', password_confirmation: '123', organization_id: org.id)}
  let!(:user6) { User.create(name: 'joe', email: 'joe@email', password: '123', password_confirmation: '123', organization_id: org.id)}
  let!(:chipotle) { Location.create(name: 'Chipotle')}
  let!(:bagels) {Location.create(name: 'The Bagel Place')}
  let!(:bar) {Location.create(name: 'A Bar')}
  let!(:subway) {Location.create(name: 'Subway')}
  let!(:gregorys) {Location.create(name: "Gregory's Coffee")}
  let!(:dunkin) {Location.create(name: "Dunkin' Donuts")}
  let!(:review1) {Review.create(user: user1, location: chipotle, score: rand(1..5), comment: Faker::Lorem.sentence)}
  let!(:review2) {Review.create(user: user2, location: bagels, score: rand(1..5), comment: Faker::Lorem.sentence)}
  let!(:review3) {Review.create(user: user3, location: subway, score: rand(1..5), comment: Faker::Lorem.sentence)}
  let!(:review4) {Review.create(user: user4, location: bar, score: rand(1..5), comment: Faker::Lorem.sentence)}
  let!(:review5) {Review.create(user: user5, location: gregorys, score: rand(1..5), comment: Faker::Lorem.sentence)}
  let!(:review6) {Review.create(user: user6, location: dunkin, score: rand(1..5), comment: Faker::Lorem.sentence)}
  let!(:plan1) { Plan.create(location: chipotle, organization: org, timing: Time.now)} #1
  let!(:plan2) { Plan.create(location: bar, organization: org, timing: Time.now + 1)} #12
  let!(:plan3) { Plan.create(location: bar, organization: org, timing: Time.now + 2)} #122
  let!(:plan4) { Plan.create(location: subway, organization: org, timing: Time.now + 2)} #1223
  let!(:plan5) { Plan.create(location: subway, organization: org, timing: Time.now + 3)} #12233
  let!(:plan6) { Plan.create(location: subway, organization: org, timing: Time.now + 4)} #122333
  let!(:plan7) { Plan.create(location: gregorys, organization: org, timing: Time.now)} #1223334
  let!(:plan8) { Plan.create(location: gregorys, organization: org, timing: Time.now + 1)} #12233344
  let!(:plan9) { Plan.create(location: gregorys, organization: org, timing: Time.now + 2)} #122333444
  let!(:plan10) { Plan.create(location: gregorys, organization: org, timing: Time.now + 3)} #1223334444
  let!(:plan11) { Plan.create(location: dunkin, organization: org, timing: Time.now)} #12233344445
  let!(:plan12) { Plan.create(location: dunkin, organization: org, timing: Time.now + 1)} #122333444455
  let!(:plan13) { Plan.create(location: dunkin, organization: org, timing: Time.now + 2)} #1223334444555
  let!(:plan14) { Plan.create(location: dunkin, organization: org, timing: Time.now + 3)} #12233344445555
  let!(:plan15) { Plan.create(location: dunkin, organization: org, timing: Time.now + 4)} #122333444455555
  let!(:outing1) { Outing.create(plan: plan1, user: user4)} #4
  let!(:outing2) { Outing.create(plan: plan2, user: user1)} #14
  let!(:outing3) { Outing.create(plan: plan2, user: user4)} #144
  let!(:outing4) { Outing.create(plan: plan3, user: user2)} #1244
  let!(:outing5) { Outing.create(plan: plan3, user: user4)} #12344
  let!(:outing6) { Outing.create(plan: plan3, user: user5)} #124445
  let!(:outing7) { Outing.create(plan: plan4, user: user2)} #1224445
  let!(:outing8) { Outing.create(plan: plan4, user: user5)} #12244455
  let!(:outing9) { Outing.create(plan: plan4, user: user3)} #122344455
  let!(:outing10) { Outing.create(plan: plan4, user: user4)} #1223444455
  let!(:outing11) { Outing.create(plan: plan4, user: user5)} #12234444555
  let!(:outing12) { Outing.create(plan: plan11, user: user2)} #112234444555
  let!(:outing13) { Outing.create(plan: plan11, user: user3)} #112234444555
  let!(:outing14) { Outing.create(plan: plan11, user: user4)} #112234444555
  let!(:outing15) { Outing.create(plan: plan11, user: user5)} #112234444555

  describe '#organization_methods' do
    it 'has a method top_locations that gets the most active locations' do
      expect(org.top_locations.count).to eq(5)
      expect(org.top_locations[4]).to eq('Chipotle')
      expect(org.top_locations[3]).to eq('A Bar')
      expect(org.top_locations[2]).to eq('Subway')
      expect(org.top_locations[1]).to eq("Gregory's Coffee")
      expect(org.top_locations[0]).to eq("Dunkin' Donuts")
      expect(org.top_locations).not_to include("The Bagel Place")
    end

    it 'has a method top_users that gets the most active users' do
      expect(org.top_users.count).to eq(5)
      expect(org.top_users[0]).to eq("Jill")
      expect(org.top_users[1]).to eq("Janet")
      expect(org.top_users[2]).to eq("Steve")
      expect(org.top_users[3]).to eq("Mary")
      expect(org.top_users[4]).to eq("Bob")
      expect(org.top_users).not_to include("Joe")
    end
  end

end
