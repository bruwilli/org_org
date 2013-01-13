namespace :db do
  desc "Fill database with sample data"
  task populate: :environment do
    admin = Editor.create!(first_name: "Example",
                           last_name: "Editor",
                           email: "example@foobar.org",
                           email_confirmation: "example@foobar.org",
                           password: "foobar12",
                           password_confirmation: "foobar12")
    admin.toggle!(:admin)
                         
    99.times do |n|
      first_name  = Faker::Name.first_name
      last_name  = Faker::Name.last_name
      email = "example-#{n+1}@railstutorial.org"
      password  = "password"
      Editor.create!(first_name: first_name,
                     last_name: last_name,
                     email: email,
                     email_confirmation: email,
                     password: password,
                     password_confirmation: password)
    end
  end
end