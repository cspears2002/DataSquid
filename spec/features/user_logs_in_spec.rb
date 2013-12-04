require 'spec_helper'

feature "signing in" do
  before :each do
    User.create(:name => 'user@example.com', :password => 'caplin')
  end

  scenario "user logs in with correct credentials" do
    visit '/authentications/new'
    
    fill_in 'Login', :with => 'user@example.com'
    fill_in 'Password', :with => 'caplin'

    click_button 'Sign in'
    expect(page).to have_content 'Hi user@example.com'
  end

  scenario "user exists in db but the wrong password is given" do
    visit '/authentications/new'

    fill_in 'Login', :with => 'user@example.com'
    fill_in 'Password', :with => 'wrong'

    click_button 'Sign in'
    expect(page).to have_content 'Wrong username/password!'
  end

  scenario "user doesn't exist in db" do
    # Makes a new user
    visit '/authentications/new'

    fill_in 'Login', :with => 'foo@example.com'
    fill_in 'Password', :with => 'foobar'

    click_button 'Sign in'
    
    visit '/users/new'
  end
end

feature "signing out" do
end