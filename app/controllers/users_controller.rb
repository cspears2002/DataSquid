class UsersController < ApplicationController

  def new
    @user = User.new(name: params[:name])
  end

  def create
    # Make the user
    @user = User.create(params[:user].permit(:name, :password))

    # Then find and authenticate the user
    user = User.find_by(name: params[:user][:name])
    if user.authenticate(params[:user][:password])
      session[:user_id] = user.id
      redirect_to user
    end
  end

  def show
  end

end
