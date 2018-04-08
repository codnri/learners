require 'rails_helper'

RSpec.feature "editing tasks" do
  
  # ref : https://github.com/easante/workout_app5/blob/master/spec/features/exercises/creating_exercise_spec.rb
  # before do
        

  # end
  
  scenario "with valid data succeeds" do
    
    @task = create(:task)
    @user = @task.subject.user
    login(@user) #LoginMacros
    

    path = "/tasks/#{@task.id}"
    link = "a[href=\'#{path}\']"
    find(link).click
    
    
    click_link "Edit"
    fill_in "Description", with: "123 pages"
    fill_in "Registration date", with: "2018-04-03 05:35:43 UTC"
    fill_in "First reminder date", with: "2018-04-04 05:35:43 UTC"
    fill_in "Second reminder date", with: "2018-04-10 05:35:43 UTC"
    fill_in "Third reminder date", with: "2018-05-03 05:35:43 UTC"
    fill_in "Subject name", with: "My Test Subject"
    click_button "Update Task"
    
    expect(page).to have_content("Task is updated successfully")
    
    expect(page).to have_content("123 pages")
    expect(page).to have_content("My Test Subject")
    

  end
  
  scenario "with invalid inputs" do
    
    @task = create(:task)
    @user = @task.subject.user
    login(@user) #LoginMacros
    

    path = "/tasks/#{@task.id}"
    link = "a[href=\'#{path}\']"
    find(link).click
    
    
    click_link "Edit"
    fill_in "Description", with: ""
    fill_in "Registration date", with: ""

    click_button "Update Task"
    
    expect(page).to have_content("Description can't be blank")
    expect(page).to have_content("Registration date can't be blank")
    
    expect(page).to have_button("Update Task")
    expect(page).not_to have_link("Edit")
    

  end
  
  scenario "User doesn't login" do
    visit '/'
    expect(page).to have_content("Sign up now!")
  end
  
  
end