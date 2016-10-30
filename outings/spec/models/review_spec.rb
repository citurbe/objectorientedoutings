require 'rails_helper'

RSpec.describe Review, type: :model do
  let(:org) { Organization.create(name: Faker::Company.name)}
  let(:loc) { Location.create(name: Faker::Company.name)}
  let(:user) { User.create(name: Faker::Name.name, password: '123', organization_id: org.id)}
  # let(:user2) { User.create(name: Faker::Name.name, password: '123', organization_id: org.id)}
  # let(:plan) { Plan.create(location_id: loc.id, user_id: user.id)}
  # let(:review) {Review.create(location_id: loc.id, user_id: user.id, score:Faker::Number.between(1,5), comment:Faker::Hacker.say_something_smart)}

  it 'should be valid with a user_id' do
    expect(FactoryGirl.build(:good_no_comment_review).valid?).to eq(true)
  end

  it 'should be INvalid withOUT a user_id' do
    expect(FactoryGirl.build(:no_user_review).valid?).to eq(false)
  end

  it 'should be valid with a location_id' do
    expect(FactoryGirl.build(:good_no_comment_review).valid?).to eq(true)
  end

  it 'should be INvalid withOUT a location_id' do
    expect(FactoryGirl.build(:no_loc_review).valid?).to eq(false)
  end

  it 'should be valid with a score' do
    expect(FactoryGirl.build(:good_no_comment_review).valid?).to eq(true)
  end

  it 'should be INvalid withOUT a score' do
    expect(FactoryGirl.build(:no_score_review).valid?).to eq(false)
  end

  it 'should be INvalid with a score outside of 1-5' do
    expect(FactoryGirl.build(:six_score_review).valid?).to eq(false)
    expect(FactoryGirl.build(:zero_score_review).valid?).to eq(false)
  end

  it 'should be INvalid with a score that is NaN' do
    expect(FactoryGirl.build(:lizard_score_review).valid?).to eq(false)
  end

  it 'should be valid with a comment' do
    expect(FactoryGirl.build(:lizard_score_review).valid?).to eq(false)
  end

  it 'should be INvalid with a score that is NaN' do
    expect(FactoryGirl.build(:lizard_score_review).valid?).to eq(false)
  end
end
