class AuthenticationsController < ApplicationController

  def new
    @user = User.new(name: params[:name])
    render :new
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
        redirect_to root_url
        flash[:alert] = "Wrong username/password!"
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
