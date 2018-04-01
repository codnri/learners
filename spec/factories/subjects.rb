FactoryGirl.define do
  factory :subject, class: Subject do
    name "Spanish words book"
    association :user  # ファクトリよびだし
  end
end