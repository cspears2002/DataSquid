require 'spec_helper'

describe "signing in", :js => true do
  before :each do
    @user = User.create(:name => 'user@example.com', :password => 'caplin')
  end

  it "allows a user to log in with correct credentials" do
    sign_in(@user)
    expect(page).to have_content 'Hi user@example.com'
  end

  it "handles a user who exists in db but gives the wrong password" do
    visit '/authentications/new'
    fill_in 'Login', with: @user.name
    fill_in 'Password', with: 'wrong'
    click_button 'Sign in'
    expect(page).to have_content 'Wrong username/password!'
  end

  it "handles a user who doesn't exist in db" do
    sign_in(user = User.create(:name => 'foo@example.com', :password => 'foobar'))

    visit '/users/new'
    fill_in 'Login', :with => 'foo@example.com'
    fill_in 'Password', :with => 'foobar'
    fill_in 'Confirm Password', :with => 'foobar'
    click_button 'Sign in'

    expect(page).to have_content 'Hi foo@example.com'
  end
end

describe "signing out", :js => true do
  before :each do
    @user = User.create(:name => 'user@example.com', :password => 'caplin')
  end

  it "logs out a user" do
    # User logs in
    sign_in(@user)
    expect(page).to have_content 'Hi user@example.com'

    # And then logs out
    click_button 'Sign out'
    expect(page).to have_content 'Signed Out!'
  end
end