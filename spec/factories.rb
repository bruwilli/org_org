FactoryGirl.define do
  factory :editor do
    sequence(:first_name)  { |n| "First#{n}" }
    sequence(:last_name)  { |n| "Last#{n}" }
    sequence(:email) { |n| "First#{n}.Last#{n}@example.com"}   
    sequence(:email_confirmation) { |n| "First#{n}.Last#{n}@example.com"}   
    password               "foobar12"
    password_confirmation  "foobar12"
  
    factory :admin do
      admin true
    end
  end
end
