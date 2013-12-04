class AuthenticationsController < ApplicationController
  before_action :authenticate_user, only: [:destroy]

  def new
    @user = User.new(name: params[:name])
    render :new
  end

end
