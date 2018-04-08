FactoryGirl.define do
  factory :subject, class: Subject do
    name "Spanish words book"
    association :user  # ファクトリよびだし
    
    factory :only_subject do #child factory
  	  user_id nil
    end
    
  end
  
end