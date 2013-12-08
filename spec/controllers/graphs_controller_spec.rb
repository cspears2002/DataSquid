require 'spec_helper'

describe GraphsController do

  before :each do
    user = User.create(:name => 'user@example.com', :password => 'caplin')
    ApplicationController.stub(:current_user).and_return(user)
  end

  it "should require json for the graph" do
    FactoryGirl.build(:graph, graph_json: {}).should_not be_valid
  end

  it "should require an existing file" do
    FactoryGirl.build(:graph, name: "Test", data: "bogus.json").should_not be_valid
  end

  it "should require a file with a json extension" do
    cvs_file = "/Users/christopherspears/wdi/DataSquid/sample.cvs"
    FactoryGirl.build(:graph, name: "Test", data: cvs_file).should_not be_valid
  end

  it "should not create a graph with blank JSON file" do
    empty_file = "/Users/christopherspears/wdi/DataSquid/empty.json"
    FactoryGirl.build(:graph, name: "Test", data: empty_file).should_not be_valid
  end


end
