class GraphsController < ApplicationController

  def new
    @graph = Graph.new
    @user = User.find(params[:user_id])
    render :new
  end

  def create
    @graph = current_user.graphs.create( graph_params )
    redirect_to :action => "show", :id => @graph.id, :user_id => current_user
  end
  
  private

  def graph_params
    params.require(:graph).permit(
      :name,
      :data
    )
  end

end
