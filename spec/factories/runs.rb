FactoryGirl.define do
  factory :run do
    date "2017-05-13"
    duration 30
    distance 500
    avg_speed 1.5
    association :user
  end
end
