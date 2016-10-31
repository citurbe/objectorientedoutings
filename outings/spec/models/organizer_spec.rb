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
  let!(:plan1) { Plan.create(location_id: bagels.id, organization_id: 1, timing: Time.now)}
  let!(:plan2) { Plan.create(location_id: chipotle.id, organization_id: 1, timing: Time.now + 1)}
  let!(:plan3) { Plan.create(location_id: chipotle.id, organization_id: 1, timing: Time.now + 2)}
  let!(:plan4) { Plan.create(location_id: bar.id, organization_id: 1, timing: Time.now + 2)}
  let!(:plan5) { Plan.create(location_id: bar.id, organization_id: 1, timing: Time.now + 3)}
  let!(:plan6) { Plan.create(location_id: bar.id, organization_id: 1, timing: Time.now + 4)}
  let!(:plan7) { Plan.create(location_id: subway.id, organization_id: 1, timing: Time.now)}
  let!(:plan8) { Plan.create(location_id: subway.id, organization_id: 1, timing: Time.now + 1)}
  let!(:plan9) { Plan.create(location_id: subway.id, organization_id: 1, timing: Time.now + 2)}
  let!(:plan10) { Plan.create(location_id: subway.id, organization_id: 1, timing: Time.now + 3)}
  let!(:plan11) { Plan.create(location_id: subway.id, organization_id: 1, timing: Time.now + 4)}
  let!(:plan11) { Plan.create(location_id: dunkin.id, organization_id: 1, timing: Time.now + 4)}
  let!(:outing1) { Outing.create(plan_id: 1, user_id: 4)} #4
  let!(:outing2) { Outing.create(plan_id: 2, user_id: 1)} #14
  let!(:outing3) { Outing.create(plan_id: 2, user_id: 4)} #144
  let!(:outing4) { Outing.create(plan_id: 3, user_id: 2)} #1244
  let!(:outing5) { Outing.create(plan_id: 3, user_id: 4)} #12344
  let!(:outing6) { Outing.create(plan_id: 3, user_id: 5)} #124445
  let!(:outing7) { Outing.create(plan_id: 4, user_id: 2)} #1224445
  let!(:outing8) { Outing.create(plan_id: 4, user_id: 5)} #12244455
  let!(:outing9) { Outing.create(plan_id: 4, user_id: 3)} #122344455
  let!(:outing10) { Outing.create(plan_id: 4, user_id: 4)} #1223444455
  let!(:outing11) { Outing.create(plan_id: 4, user_id: 5)} #12234444555
  let!(:outing11) { Outing.create(plan_id: 11, user_id: 1)} #112234444555

  it 'has a method top_locations that gets the most active locations' do
    byebug
    expect(org.top_locations.count).to eq(5)
    expect(org.top_locations[0]).to eq('Subway')
  end

  it 'has a method top_users that gets the most active users' do
    expect(org.top_users.count).to eq(5)
    expect(org.top_users[0]).to eq("Jill")
    expect(org.top_users[1]).to eq("Janet")
    expect(org.top_users[2]).to eq("Steve")
    expect(org.top_users[3]).to eq("Bob")
    expect(org.top_users[4]).to eq("Mary")
    expect(org.top_users).to !include?("Joe")
  end

end
