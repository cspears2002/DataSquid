require 'spec_helper'

describe "the signin process", :type => :feature do
  before :each do
    User.create(:name => 'user@example.com', :password => 'caplin')
  end

  it "signs me in" do
    visit '/authentications/new'
    within("#authentication") do
      fill_in 'Login', :with => 'user@example.com'
      fill_in 'Password', :with => 'password'
    end
    click_link 'Sign in'
    expect(page).to have_content 'Success'
  end
end