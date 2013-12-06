require 'spec_helper'

feature "creating graph" do
  before :each do
    @user = User.create(:name => 'user@example.com', :password => 'caplin')
  end

  file_path = '/Users/christopherspears/wdi/DataSquid/'

  scenario "with a graph name and properly formatted JSON" do
    sign_in(@user)
    visit '/users/:user_id/graphs/new'

    fill_in 'Graph Name', with: 'Test'
    attach_file('Data', file_path + 'sample.json')
    click_button('Create Graph')
  end

  scenario "with a graph name and a file with the wrong extension" do
  end

  scenario "with a graph name and a blank JSON" do
  end

  scenario "with a graph name and a improperly formatted JSON" do
  end

  scenario "with no graph name and properly formatted JSON" do
  end

  scenario "with a graph name and no file" do
  end

end