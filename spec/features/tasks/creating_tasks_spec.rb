require 'rails_helper'

RSpec.feature "creating tasks" do
  
  # before do
        

  # end
  
  scenario "with valid inputs" do
    
    @subject = create(:subject)
    @user = @subject.user
    login(@user) #LoginMacros
    

    visit '/'
    click_link "New Task"
    fill_in "Description", with: "123 pages"
    fill_in "Start", with: "2018-04-03 05:35:43 UTC"
    fill_in "First reminder date", with: "2018-04-04 05:35:43 UTC"
    fill_in "Second reminder date", with: "2018-04-10 05:35:43 UTC"
    fill_in "Third reminder date", with: "2018-05-03 05:35:43 UTC"
    # fill_in "subject_selection", with: ""
    
    select @subject.name, :from => 'task[subject_id]'
    # within '#existing_task' do
    #   find("option[value='1']").select_option
    # end
    click_button "Create Task"
    
    expect(page).to have_content("Task is created successfully")
    
    expect(page).to have_content("123 pages")
    expect(page).to have_content(@subject.name)
    

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