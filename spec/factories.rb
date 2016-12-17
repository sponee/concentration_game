FactoryGirl.define do
  factory :user do
    email "kyle.sponheim@gmail.com"
    password "12345678"
  end

  factory :game do 
    id 1
    player_one_id 1
    player_two_id 2
  end
end