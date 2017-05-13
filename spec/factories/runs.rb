FactoryGirl.define do
  factory :run do
    date "2017-05-13"
    duration 1
    distance 1
    avg_speed 1.5
    association :user
  end
end
