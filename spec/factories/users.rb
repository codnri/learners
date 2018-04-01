FactoryGirl.define do

  factory :user, class: User do
    firstname "John"
    lastname "White"
    email "foobar@gmail.com"
    admin true
    password "password"
    password_confirmation "password"
    
    factory :invalid_user do
			firstname nil
		end
  end
  
end