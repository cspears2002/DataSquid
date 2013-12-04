class UsersController < ApplicationController

  def new
    @user = User.new(name: params[:name])
  end

  def create
    @user = User.create(params[:user].permit(:name, :password))

    # Try to find and authenticate the user
    user = User.find_by(name: params[:user][:name])
    if user.authenticate(params[:user][:password])
      session[:user_id] = user.id
      redirect_to user
    end
  end

end
