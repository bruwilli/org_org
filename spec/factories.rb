FactoryGirl.define do
  factory :org_type_editor do
    first_name             "Bruce"
    last_name              "Williams"
    email                  "brucew@foobar.com"
    email_confirmation     "brucew@foobar.com"
    password               "foobar12"
    password_confirmation  "foobar12"
  end
end