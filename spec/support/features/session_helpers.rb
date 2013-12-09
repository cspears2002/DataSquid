module Features
  module SessionHelpers

    def sign_in(user=nil)
      user ||= FactoryGirl.create(:user)
      visit '/authentications/new'
      fill_in 'Login', with: user.name
      fill_in 'Password', with:  user.password
      click_button 'Sign in'
    end

    def validate_graph_creation(user=nil, 
                                graph_name,
                                file_path,
                                msg)

      # create a user and sign in
      user ||= FactoryGirl.create(:user)
      sign_in(user)

      # important paths
      new_graphs_array = ['/users', user.id, 'graphs', 'new']
      new_graphs_route = new_graphs_array.join('/')

      # try to make a graph
      visit new_graphs_route

      fill_in 'Graph Name', with: graph_name
      
      fill_in 'File Path', with: file_path
      click_button('Create Graph')
      expect(page).to have_content msg
    end
    
  end
end