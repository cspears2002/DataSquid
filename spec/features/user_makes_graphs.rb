require 'spec_helper'

feature "creating graph" do
  before :each do
    @user = User.create(:name => 'user@example.com', :password => 'caplin')
  end

  scenario "with a graph name and properly formatted JSON or CVS file" do
  end

  scenario "with a graph name and a file with the wrong extension" do
  end

  scenario "with a graph name and a blank JSON or CVS file" do
  end

  scenario "with a graph name and a improperly formatted JSON or CVS file" do
  end

  scenario "with no graph name and properly formatted JSON or CVS file" do
  end

  scenario "with a graph name and no file" do
  end

end