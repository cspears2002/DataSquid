require 'spec_helper'

describe "creating graph", :js => true do
  before :each do
    @user = User.create(:name => 'user@example.com', :password => 'caplin')
  end

  it "creates a graph with a graph name and properly formatted JSON" do
    file_path = '/Users/christopherspears/wdi/DataSquid/sample.json'
    validate_graph_creation(@user, file_path, 'Created')
  end

  it "tests that a file exists" do
    file_path = '/Users/christopherspears/wdi/DataSquid/bogus.json'
    validate_graph_creation(@user, file_path, 'JSON is invalid.')
  end

  it "requires a file with a json extension" do
    file_path = '/Users/christopherspears/wdi/DataSquid/sample.cvs'
    validate_graph_creation(@user, file_path, 'JSON is invalid.')
  end

  it "tests that a file is blank" do
    file_path = '/Users/christopherspears/wdi/DataSquid/empty.json'
    validate_graph_creation(@user, file_path, 'JSON is invalid.')
  end
end