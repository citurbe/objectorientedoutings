FactoryGirl.define do
  
  factory :good_comment_review, :class => 'Review' do
    location_id 1
    user_id 1
    score 4
    comment "Faker::Hacker.say_something_smart"
  end
  factory :good_no_comment_review, :class => 'Review' do
    location_id 1
    user_id 1
    score 2
    comment nil
  end
  factory :no_user_review, :class => 'Review' do
    location_id 1
    user_id nil
    score Faker::Number.between(1,5)
    comment Faker::Hacker.say_something_smart
  end
  factory :no_loc_review, :class => 'Review' do
    location_id nil
    user_id 1
    score Faker::Number.between(1,5)
    comment Faker::Hacker.say_something_smart
  end
  factory :no_score_review, :class => 'Review' do
    location_id 1
    user_id 1
    score nil
    comment Faker::Hacker.say_something_smart
  end
  factory :six_score_review, :class => 'Review' do
    location_id 1
    user_id 1
    score 6
    comment Faker::Hacker.say_something_smart
  end
  factory :zero_score_review, :class => 'Review' do
    location_id 1
    user_id 1
    score 0
    comment Faker::Hacker.say_something_smart
  end
  factory :lizard_score_review, :class => 'Review' do
    location_id 1
    user_id 1
    score "lizard"
    comment Faker::Hacker.say_something_smart
  end

end
