require 'rails_helper'

RSpec.feature "creating tasks" do
  
  # ref : https://github.com/easante/workout_app5/blob/master/spec/features/exercises/creating_exercise_spec.rb
  # before do
        

  # end
  
  scenario "with valid inputs" do
    
    @user = create(:user)
    login(@user) #LoginMacros
    

    visit '/'
    click_link "New Task"
    fill_in "Description", with: "123 pages"
    fill_in "Registration date", with: "2018-04-03 05:35:43 UTC"
    fill_in "First reminder date", with: "2018-04-04 05:35:43 UTC"
    fill_in "Second reminder date", with: "2018-04-10 05:35:43 UTC"
    fill_in "Third reminder date", with: "2018-05-03 05:35:43 UTC"
    fill_in "Subject name", with: "My Test Subject"
    click_button "Create Task"
    
    expect(page).to have_content("Task is created successfully")
    
    expect(page).to have_content("123 pages")
    expect(page).to have_content("My Test Subject")
    

  end
  
  scenario "with invalid inputs" do
    @user = create(:user)
    login(@user) 
    visit '/'
    click_link "New Task"
    click_button "Create Task"

    expect(page).to have_content("Subject must exist")
    expect(page).to have_content("Subject can't be blank")
    expect(page).to have_content("Description can't be blank")
    
    expect(page).to have_button('Create Task')
    expect(page).to have_no_link("Edit")

  end
  
  scenario "User doesn't login" do
    visit '/'
    expect(page).to have_content("Sign up now!")
  end
  
  
end