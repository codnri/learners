require 'rails_helper'

describe Task do
  it "is valid with a description, 1-3rd_registration_date,reminder_dates and subject_id" do
    expect(FactoryGirl.build(:task)).to be_valid
  end

  it "is invalid without a description" do
    task = build(:task, description: nil )
    task.valid?
    expect(task.errors[:description]).to include("can't be blank")
  end
  
  it "is invalid without a registration_date" do
    task = build(:task, registration_date: nil )
    task.valid?
    expect(task.errors[:registration_date]).to include("can't be blank")
  end
  
  it "is invalid without a first_reminder_date" do 
    task = build(:task, first_reminder_date: nil )
    task.valid?
    expect(task.errors[:first_reminder_date]).to include("can't be blank")
  end
  
  it "is invalid without a second_reminder_date" do
    task = build(:task, second_reminder_date: nil )
    task.valid?
    expect(task.errors[:second_reminder_date]).to include("can't be blank")
  end
  
  it "is invalid without a third_reminder_date" do
    task = build(:task, third_reminder_date: nil )
    task.valid?
    expect(task.errors[:third_reminder_date]).to include("can't be blank")
  end
  
  it "is invalid without a subject_id" do
    task = build(:task, subject_id: nil )
    task.valid?
    expect(task.errors[:subject]).to include("can't be blank")
  end
  
  
  # check the order of reminder_dates
  it "is invalid with third_reminder_date that is earlier than second_reminder_date" do
    task = build(:task)
    task.third_reminder_date = task.second_reminder_date.ago(1.days)
    task.valid?
    expect(task.errors[:third_reminder_date]).to include("is earlier than second_reminder_date")

  end
  
  it "is invalid with second_reminder_date that is earlier than first_reminder_date" do
    task = build(:task)
    task.second_reminder_date = task.first_reminder_date.ago(1.days)
    task.valid?
    expect(task.errors[:second_reminder_date]).to include("is earlier than first_reminder_date")
  end
  
  it "is invalid with first_reminder_date that is earlier than registration_date" do
    task = build(:task)
    task.first_reminder_date = task.registration_date.ago(1.days)
    task.valid?
    expect(task.errors[:first_reminder_date]).to include("is earlier than registration_date")
  end
  
  # check the subject_id is an invalid id
  it "is invalid with nonexistent subject_id" do 
    task = build(:task)
    task.subject_id = Subject.count + 1 
    task.valid?
    expect(task.errors[:subject]).to include("must exist")
  end
  
end