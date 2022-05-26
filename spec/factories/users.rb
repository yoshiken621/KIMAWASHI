FactoryBot.define do
  factory :user do
    nickname       {'ken'}
    age_select_id  { 2 } 
    sex_select_id  { 2 }
    email          {'a@a'}
    password  {'oooooo'}
    password_confirmation {password}
  end
end