# create_table "plans", force: :cascade do |t|
#   t.integer  "location_id"
#   t.integer  "organizer_id"
#   t.datetime "timing"
#   t.datetime "created_at",      null: false
#   t.datetime "updated_at",      null: false
#   t.integer  "organization_id"
# end

require 'rails_helper'

RSpec.describe Plan, type: :model do
  let(:org) { Organization.create(name: 'Google')}
  let(:chipotle) { Location.create(name: 'Chipotle')}
  let(:bagels) {Location.create(name: 'The Bagel Place')}
  let!(:user) { User.create(name: 'boB SMith', email: 'email@email', password: '123', password_confirmation: '123',phone: "9146935919", organization_id: org.id)}
  let!(:user2) { User.create(name: 'Mary', password: '123', email: 'email@email', password_confirmation: '123', phone:"914-693-4922", organization_id: org.id)}
  let!(:review1) {Review.create(user: user, location: chipotle, score: 3, comment: Faker::Lorem.sentence)}
  let!(:review2) {Review.create(user: user, location: chipotle, score: 1, comment: Faker::Lorem.sentence)}
  let!(:plan) { Plan.create(location: bagels, organizer: user, timing: Time.now)}
  let!(:outing) { Outing.create(plan: plan, user: user)}

  describe "#summary" do
    it "my_summary grabs name, day, and time and displays them" do
      expect(plan.my_summary).to include(plan.day)
      expect(plan.my_summary).to include(plan.location.name)
      expect(plan.my_summary).to include(plan.time)
    end
    it "other_summary displays additional data including organizer_name" do
      expect(plan.other_summary).to include(plan.day)
      expect(plan.other_summary).to include(plan.location.name)
      expect(plan.other_summary).to include(plan.time)
    end
    it "user_summary displays the data from the perspective of another user" do
      expect(plan.user_summary(user)).to include(plan.day)
      expect(plan.user_summary(user)).to include(user.camel_case)
      expect(plan.user_summary(user)).to include(plan.time)
    end
    it "loc_summary displays the data from the utility perspective of a location" do
      expect(plan.loc_summary).to include(plan.day)
      expect(plan.loc_summary).to include(plan.organizer.camel_case)
      expect(plan.loc_summary).to include(plan.time)
    end
  end
end
