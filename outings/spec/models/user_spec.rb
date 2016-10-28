require 'rails_helper'

RSpec.describe User, type: :model do
  let(:org) { Organization.create(name: 'Google')}
  let(:loc) { Location.create(name: 'Chipotle')}
  let(:user) { User.create(name: 'bob', password: '123', organization_id: org.id)}
  let(:user2) { User.create(name: 'Mary', password: '123', organization_id: org.id)}
  let(:plan) { Plan.create(location_id: loc.id, user_id: user.id)}

  describe '#name' do
    it 'has a name' do
      expect(user.name).to eq('Bob')
    end
end
