class UsersController < ApplicationController
  before_filter :add_breadcrumbs, :only => [:show]

  def new
    @user = User.new(name: params[:name])
  end

  def create
    @user = User.create(params[:user].permit(:name, :password))
    user = User.find_by(name: params[:user][:name])
    if user.authenticate(params[:user][:password])
      session[:user_id] = user.id
      redirect_to user
    end
  end

  def show
    @user = User.find(params[:id])
  end

  private

  def add_breadcrumbs
    add_breadcrumb current_user.name, user_path(current_user)
  end

end
