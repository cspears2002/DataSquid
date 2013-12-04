require 'spec_helper'

feature "signing in" do
  before :each do
    User.create(:name => 'user@example.com', :password => 'caplin')
  end

  scenario "logs in with correct credentials" do
    visit '/authentications/new'
    
    fill_in 'Login', :with => 'user@example.com'
    fill_in 'Password', :with => 'password'

    click_button 'Sign in'
    expect(page).to have_content 'Success'
  end

  # User doesn't exist in db.
  it "creates a new user" do
  end

  # User exists in db but the wrong password is given.
  it "will not let me log in" do
  end

end

feature "signing out" do
end