require "rails_helper"

RSpec.feature "showing subjects" do
  
  scenario "show subjects and list all the related tasks" do
    
    @task = create(:task)
    @subject = @task.subject
    @task2 = create(:only_task, description: "Chapter 6", subject_id: @subject.id)

    
    @user = @task.subject.user
    login(@user) #LoginMacros
    visit "/"
    
    
    link = "a[href=\'/subjects/#{@subject.id}\']"
    first(link).click

    # find.first("a[href=\'/subjects/#{@subject.id}\']").click
    #e.g. href="/subjects/107"
    
    expect(page).to have_content(@task.description)
    expect(page).to have_content(@task2.description)
    
  end
  
  scenario "User doesn't login" do
    @task = create(:task)
    @subject = @task.subject
    @user = @task.subject.user
  
    visit "/subjects/#{@subject.id}"
    # access to subject detail page
    expect(page).to have_content("Sign up now!")
  end
end