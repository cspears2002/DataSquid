require 'spec_helper'

describe "creating graph", :js => true do
  before :each do
    @user = User.create(:name => 'user@example.com', :password => 'caplin')
  end

  it "creates a graph with a graph name and properly formatted JSON" do
    sign_in(@user)

    # important paths
    new_graphs_array = ['/users', @user.id, 'graphs', 'new']
    new_graphs_route = new_graphs_array.join('/')

    visit new_graphs_route

    fill_in 'Graph Name', with: 'Test'
    file_path = '/Users/christopherspears/wdi/DataSquid/'
    attach_file 'Data', file_path + 'sample.json'
    click_button('Create Graph')
    expect(page).to have_content 'Created ' + @graph.name
  end

  it "tries to create a graph with a graph name and a file with the wrong extension" do
  end

  it "tries to create a graph with a graph name and a blank JSON" do
  end

  it "tries to create a graph with a graph name and a improperly formatted JSON" do
  end

  it "tries to create a graph with no graph name and properly formatted JSON" do
  end

  it "tries to create a graph with a graph name and no file" do
  end

end