require 'spec_helper'

describe "the signin process", :type => :feature do
  before :each do
    User.create(:name => 'user@example.com', :password => 'caplin')
  end

  feature "user logs in" do
    context "successfully" do
      # User logs in with correct credentials.
      scenario "logs in with correct credentials" do
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
    end
  end

  # User doesn't exist in db.
  it "creates a new user" do
  end

  # User exists in db but the wrong password is given.
  it "will not let me log in" do
  end

end

describe "the signout process", :type => :feature do
end