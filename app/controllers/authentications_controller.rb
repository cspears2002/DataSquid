class AuthenticationsController < ApplicationController
  before_action :authenticate_user, only: [:destroy]

  def new
    if current_user
      redirect_to users_url
    else
      @user = User.new(name: params[:name])
      render :new
    end
  end

  def create
    # Find user
    user = User.find_by(name: params[:user][:name])

    if user
      # Authenticate user
      if user.authenticate(params[:user][:password])
        session[:user_id] = user.id
        redirect_to user
      else
        # Doesn't work so try again
        flash[:alert] = "Wrong username/password!"
        redirect_to root_url
      end
    else
      # Make a new user
      redirect_to new_user_url(name: params[:user][:name])
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_url
    flash[:notice] = "Signed Out!"
  end

end
