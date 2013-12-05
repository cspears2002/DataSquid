module Features
  module SessionHelpers
    def sign_in
      user = create(:user)
      visit '/authentications/new'
      fill_in 'Login', with: user.name
      fill_in 'Password', with:  user.password
      click_button 'Sign in'
    end
  end
end