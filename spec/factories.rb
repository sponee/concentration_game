FactoryGirl.define do
  factory :user do
    email {"user_#{rand(1000).to_s}@factory.com" }
    password "12345678"
  end

  factory :game do 
    player_one_id 1
    player_two_id 2
  end
end