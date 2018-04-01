FactoryGirl.define do
  factory :task, class: Task do
    description "Chapter 5"
    done  false
    registration_date { Time.now }
    first_reminder_date { Time.now.since(1.days) }
    second_reminder_date { Time.now.since(7.days) }
    third_reminder_date { Time.now.since(30.days) }

    association :subject # ファクトリよびだし
    

    factory :invalid_task do #child factory
			description nil
		end
    
    
  end

  # factory :subject, class: Subject do
  #   name "Spanish words book"
  #   association :user  # ファクトリよびだし
  # end
  
  
  # factory :user, class: User do
  #   firstname "John"
  #   lastname "White"
  #   email "foobar@gmail.com"
  #   admin true
  #   password "password"
  #   password_confirmation "password"
    
  #   factory :invalid_user do
		# 	firstname nil
		# end
  # end
  
end