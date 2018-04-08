require "rails_helper"

RSpec.feature "Deleting Task" do
  
  scenario do
    @task = create(:task)
    @user = @task.subject.user
    login(@user)
    visit '/'
    
    
    path = "/tasks/#{@task.id}"
    link = "a[href=\'#{path}\']"
    find(link).click



    link = find_link 'Delete'
    expect(link['data-confirm']).to eq 'Are you sure?'
    
    click_link "Delete"
    
    expect(page).to have_content("Task deleted")
    
    
    
  end
  
  
end