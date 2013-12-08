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
    fill_in 'Data', with: file_path + 'sample.json'
    click_button('Create Graph')
    expect(page).to have_content 'Created'
  end

  it "tests that a file exists" do
    sign_in(@user)

    # important paths
    new_graphs_array = ['/users', @user.id, 'graphs', 'new']
    new_graphs_route = new_graphs_array.join('/')

    visit new_graphs_route

    fill_in 'Graph Name', with: 'Test'
    file_path = '/Users/christopherspears/wdi/DataSquid/'
    fill_in 'Data', with: file_path + 'bogus.json'
    click_button('Create Graph')
    expect(page).to have_content 'JSON is invalid.'
  end

  it "requires a file with a json extension" do
    sign_in(@user)

    # important paths
    new_graphs_array = ['/users', @user.id, 'graphs', 'new']
    new_graphs_route = new_graphs_array.join('/')

    visit new_graphs_route

    fill_in 'Graph Name', with: 'Test'
    file_path = '/Users/christopherspears/wdi/DataSquid/'
    fill_in 'Data', with: file_path + 'sample.cvs'
    click_button('Create Graph')
    expect(page).to have_content 'JSON is invalid.'
  end

  it "tests that file is blank" do
    sign_in(@user)

    # important paths
    new_graphs_array = ['/users', @user.id, 'graphs', 'new']
    new_graphs_route = new_graphs_array.join('/')

    visit new_graphs_route

    fill_in 'Graph Name', with: 'Test'
    file_path = '/Users/christopherspears/wdi/DataSquid/'
    fill_in 'Data', with: file_path + 'empty.json'
    click_button('Create Graph')
    expect(page).to have_content 'JSON is invalid.'
  end


end