require 'rails_helper'

RSpec.feature "listing tasks" do
  
  # before do
        

  # end
  
  scenario "shows all own tasks" do
    @task = create(:task)
    @subject = @task.subject
    @user = @task.subject.user
    login(@user) #LoginMacros

    @task2 = create(:only_task, description: "Chapter 6", subject_id: @subject.id)
    
    @another_user = create(:user, email: "user2@test.com")
    @another_subject = create(:only_subject, user_id: @another_user.id)
    @another_task = create(:only_task, subject_id: @another_subject.id,description: "Another Task")
    # @task = @user1.tasks.build(:task)
    visit '/'
    
    expect(page).to have_content(@task.description)
    # expect(page).to have_content(timeParse @task.registration_date)
    expect(page).to have_content(timeParse @task.first_reminder_date)
    expect(page).to have_content(timeParse @task.second_reminder_date)
    expect(page).to have_content(timeParse @task.third_reminder_date)
    
    expect(page).to have_content(@task2.description)
    # expect(page).to have_content(timeParse @task2.registration_date)
    expect(page).to have_content(timeParse @task2.first_reminder_date)
    expect(page).to have_content(timeParse @task2.second_reminder_date)
    expect(page).to have_content(timeParse @task2.third_reminder_date)
    
    

    expect(page).not_to have_content(@another_task.description)
    # expect(page).not_to have_content(@another_task.registration_date)
    # expect(page).not_to have_content(@another_task.first_reminder_date)
    # expect(page).not_to have_content(@another_task.second_reminder_date)
    # expect(page).not_to have_content(@another_task.third_reminder_date)
    
    # expect(@task2.description).to eq "Chapter 6"
    # expect(@task.subject.name).to eq "Spanish words book"
  end
  
  scenario "shows no tasks" do
    @user_without_tasks = create(:user, email: "user3@test.com")
    login(@user_without_tasks)
    visit '/'
    expect(page).to have_content("No Task")
    expect(page).not_to have_content("description")

    
  end
  
  scenario "User doesn't login" do
    visit '/'
    expect(page).to have_content("Sign up now!")
  end
  
  
end