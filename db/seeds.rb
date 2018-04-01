# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

100.times do |n|

  lastname=Faker::Name.last_name 
  firstname=Faker::Name.first_name 
  email=Faker::Internet.free_email(lastname+'.'+firstname) 
  admin=[true,false].sample
  #！をつけることによりActiveRecord::RecordNotFoundエラーを発生させることができる
  user = User.create!(
    lastname:lastname,
    firstname:firstname,
    email:email,
    admin:admin,
    password:'password',
    password_confirmation:'password'
    )
    
  name=Faker::Book.title
  description=Faker::Lorem.sentence
  url=Faker::Internet.url 
  shared=[true,false].sample
  
  subject= user.subjects.create!(
    name:name,
    description:description,
    url:url,
    shared:shared,
    )
  
  #rangeからランダムに値を取る
  Random.rand(3 .. 7).times do |m|
    title=subject.name
    description=Faker::Lorem.sentence
    done=[true, false].sample
    registration_date= Faker::Time.between(DateTime.now - 200, DateTime.now-1) 
    first_reminder_date=registration_date.since(1.day)
    second_reminder_date=registration_date.since(7.days)
    third_reminder_date=registration_date.since(1.month)
  
    subject.tasks.create!(
                title: title,
                description: description,
                done: done,
                registration_date: registration_date,
                first_reminder_date: first_reminder_date,
                second_reminder_date: second_reminder_date,
                third_reminder_date: third_reminder_date
    )
  end
end