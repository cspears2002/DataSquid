require 'spec_helper'

feature "signing in" do
  before :each do
    @user = User.create(:name => 'user@example.com', :password => 'caplin')

    # for controllers
    # user = User.create(:name => 'user@example.com', :password => 'caplin')
    # ApplicationController.stub(:current_user).and_return(user)
  end

  scenario "user who logs in with correct credentials" do
    sign_in(@user)
    expect(page).to have_content 'Hi user@example.com'
  end

  scenario "user who exists in db but the wrong password is given" do
    visit '/authentications/new'
    fill_in 'Login', with: @user.name
    fill_in 'Password', with: 'wrong'
    click_button 'Sign in'
    expect(page).to have_content 'Wrong username/password!'
  end

  scenario "user who doesn't exist in db" do
    sign_in(user = User.create(:name => 'foo@example.com', :password => 'foobar'))

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
    @user = User.create(:name => 'user@example.com', :password => 'caplin')
  end

  scenario "logged in user" do
    # User logs in
    sign_in(@user)
    expect(page).to have_content 'Hi user@example.com'

    # And then logs out
    click_button 'Sign out'
    expect(page).to have_content 'Signed Out!'
  end
end