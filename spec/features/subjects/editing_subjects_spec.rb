require "rails_helper"



# /learners/app/helpers/application_helper.rb
RSpec.feature "editing subjects" do
  
  before do
    @task = create(:task)
    @subject = @task.subject
    @user = @task.subject.user
    login(@user) #LoginMacros
  end
  scenario "edit subjects with valid data" do
    
    # include ActionView::Helpers
    # include ActionView::ApplicationHelper
    # ApplicationHelper
    visit "/"
    
    
    link = "a[href=\'/subjects/#{@subject.id}\']"
    first(link).click

    click_link "Edit"    
    new_name = "Learning Thai cooking"
    fill_in "Name", with: new_name
    click_button "Update Subject"

    
    expect(page).to have_content("Subject : "+new_name)
    expect(page).to have_content(@task.description)
    expect(page).to have_content(timeParse @task.first_reminder_date)
    
    
  end

  scenario "edit subjects with invalid data" do
    visit "/"
    
    
    link = "a[href=\'/subjects/#{@subject.id}\']"
    first(link).click

    click_link "Edit"    
    new_name = ""
    fill_in "Name", with: new_name
    click_button "Update Subject"
    
    
    expect(page).to have_content("Name can't be blank")
    expect(page).to have_content("Subject has not been updated")
    
    expect(page).to have_current_path("/subjects/#{@subject.id}")


    
    
  end

  

end