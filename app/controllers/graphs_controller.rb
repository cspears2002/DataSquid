class GraphsController < ApplicationController

  def index
  end

  def new
    @graph = Graph.new
    @user = User.find(params[:user_id])
    render :new
  end

  def create
    @graph = current_user.graphs.new( graph_params )

    # Parse the json file and store the json to Postgresql
    @graph.graph_json = @graph.parse_file(@graph.data)

    if @graph.graph_json
      @graph.save
      redirect_to :action => "show", :id => @graph.id, :user_id => current_user
    else
      flash[:alert] = "JSON is invalid."
      redirect_to user_graphs_url
    end
  end

  def show
    @graph = Graph.find(params[:id])
  end
  
  private

  def graph_params
    params.require(:graph).permit(:name, :data, :graph_json)
  end

end
