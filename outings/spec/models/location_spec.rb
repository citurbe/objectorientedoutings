require 'rails_helper'

RSpec.describe Location, type: :model do
  let!(:user) { User.create(name: 'bob', email: 'email@email', password: '123', password_confirmation: '123',phone: "9146935919", organization_id: org.id)}
  let!(:org) { Organization.create(name: 'Google')}
  let!(:chipotle) { Location.create(name: 'Chipotle')}
  let!(:bagels) {Location.create(name: 'The Bagel Place')}
  let!(:bar) {Location.create(name: 'A Bar')}
  let!(:subway) {Location.create(name: "Subway'")}
  let!(:gregorys) {Location.create(name: "Gregory's Coffee")}
  let!(:plan1) { Plan.create(location_id: bagels.id, timing: '20120618 10:34:09 AM')}
  let!(:plan2) { Plan.create(location_id: chipotle.id, timing: '20120618 02:34:09 PM')}
  let!(:plan3) { Plan.create(location_id: bar.id, timing: '20120618 11:34:09 PM')}
  let!(:plan4) { Plan.create(location_id: subway.id, timing: '20120618 11:34:09 PM')}
  let!(:plan5) { Plan.create(location_id: subway.id, timing: '20120618 11:34:09 AM')}

  describe '#time_of_day' do
    it 'correctly identifies a morning place' do
      expect(bagels.time_of_day).to include("morning")
    end

    it 'correctly identifies an afternoon place' do
      expect(chipotle.time_of_day).to include("afternoon")
    end

    it 'correctly identifies an evening place' do
      expect(bar.time_of_day).to include("evening")
    end

    it 'correctly identifies an ambiguous place' do
      expect(subway.time_of_day).to include("busy")
    end
  end


end
