require 'spec_helper'

describe Graph do
  pending "add some examples to (or delete) #{__FILE__}"

  it "should require a name" do
    FactoryGirl.build(:graph, name: "").should_not be_valid
  end

  it "should require a file path" do
    FactoryGirl.build(:graph, data: "").should_not be_valid
  end

end
