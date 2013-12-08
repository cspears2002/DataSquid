require 'spec_helper'

describe GraphsController do

  before :each do
    user = User.create(:name => 'user@example.com', :password => 'caplin')
    ApplicationController.stub(:current_user).and_return(user)
  end

end
