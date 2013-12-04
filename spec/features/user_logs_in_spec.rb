require 'spec_helper'

feature "signing in" do
  before :each do
    User.create(:name => 'user@example.com', :password => 'caplin')
  end

  scenario "user who logs in with correct credentials" do
    visit '/authentications/new'
    
    fill_in 'Login', :with => 'user@example.com'
    fill_in 'Password', :with => 'caplin'

    click_button 'Sign in'
    expect(page).to have_content 'Hi user@example.com'
  end

  scenario "user who exists in db but the wrong password is given" do
    visit '/authentications/new'

    fill_in 'Login', :with => 'user@example.com'
    fill_in 'Password', :with => 'wrong'

    click_button 'Sign in'
    expect(page).to have_content 'Wrong username/password!'
  end

  scenario "user who doesn't exist in db" do
    visit '/authentications/new'
    fill_in 'Login', :with => 'foo@example.com'
    fill_in 'Password', :with => 'foobar'
    click_button 'Sign in'

    visit '/users/new'
    fill_in 'Login', :with => 'foo@example.com'
    fill_in 'Password', :with => 'foobar'
    fill_in 'Confirm Password', :with => 'foobar'
    click_button 'Sign in'

    expect(page).to have_content 'Hi foo@example.com'
  end
end

feature "signing out" do
  before :each do
    User.create(:name => 'user@example.com', :password => 'caplin')
  end

  scenario "logged in user" do
    # User logs in
    visit '/authentications/new'
    
    fill_in 'Login', :with => 'user@example.com'
    fill_in 'Password', :with => 'caplin'

    click_button 'Sign in'
    expect(page).to have_content 'Hi user@example.com'

    # And then logs out
    click_button 'Sign out'
    expect(page).to have_content 'Signed Out!'
  end
end