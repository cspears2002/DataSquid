require 'spec_helper'

describe Graph do
  pending "add some examples to (or delete) #{__FILE__}"

  it "should require a name" do
    FactoryGirl.build(:graph, name: "").should_not be_valid
  end

  it "should require a file path" do
    FactoryGirl.build(:graph, data: "").should_not be_valid
  end

  it "should require an existing file" do
    @user = FactoryGirl.create(:user)
    FactoryGirl.build(:graph, user: @user, name: "Test", data: "bogus.json").should_not be_valid
  end

  it "should not create a graph given a file with the wrong extension" do
    cvs_file = "/Users/christopherspears/wdi/DataSquid/sample.cvs"
    FactoryGirl.build(:graph, name: "Test", data: cvs_file).should_not be_valid
  end

  it "should not create a graph with blank JSON file" do
    empty_file = "/Users/christopherspears/wdi/DataSquid/empty.json"
    FactoryGirl.build(:graph, name: "Test", data: empty_file).should_not be_valid
  end

  it "should not create a graph with an improperly formatted JSON file" do
  end

end
