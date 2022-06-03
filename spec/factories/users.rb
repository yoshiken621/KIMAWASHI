FactoryBot.define do
  factory :user do
    nickname       {Faker::Name.initials(number: 2)}
    age_select_id  { 2 } 
    sex_select_id  { 2 }
    email          {Faker::Internet.free_email}
    password  {'oooooo'}
    password_confirmation {password}
  end
end