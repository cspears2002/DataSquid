module Features
  module SessionHelpers
    def sign_in
      current_user = create(:user)
      visit '/authentications/new'
      fill_in 'Login', with: current_user.name
      fill_in 'Password', with: current_user.password
      click_button 'Sign in'
    end
  end
end