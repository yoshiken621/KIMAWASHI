FactoryBot.define do
  factory :event do
    date {Faker::Date.between(from: '2014-09-23', to: '2014-09-25')}
    events_select_id { 2 }
    met_person { 'aaa' }
    checkbox { 1 }

    user 


  end
end
