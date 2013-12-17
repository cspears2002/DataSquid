require 'nodes.rb'
require 'links.rb'

class GraphsController < ApplicationController
  before_filter :add_breadcrumbs

  def index
    @user = User.find(params[:user_id])
    @graphs = Graph.where(user_id: @user.id)
  end

  def new
    @graph = Graph.new
    @user = User.find(params[:user_id])
    render :new, layout: false
  end

  def create
    @graph = current_user.graphs.new( graph_params )

    # Parse the json file and store the json to Postgresql
    @graph.graph_json = @graph.parse_file(@graph.data)

    if @graph.graph_json
      @graph.save

      # Get links and nodes
      links = @graph.graph_json["links"]
      nodes = @graph.graph_json["nodes"]

      # Make nodes
      nodes_array = Array.new
      nodes.each do |node|
        @node = Nodes.new(node)
        @node.save
        nodes_array.push(@node)
      end

      #Make links
      links.each do |link|
        src_index = link["source"]
        target_index = link["target"]
        @link = Links.new(nodes_array[src_index],
                          nodes_array[target_index],
                          link["value"])
        @link.save
        puts @link
      end

      redirect_to :action => "show", :id => @graph.id, :user_id => current_user
    else
      flash[:alert] = "JSON is invalid."
      redirect_to user_graphs_url
    end
  end

  def show
    @user = User.find(params[:user_id])
    @graph = Graph.find(params[:id])
    add_breadcrumb "Views", user_graph_path(@user.id, @graph.id)
  end

  def edit
    # @user = User.find(params[:user_id])
    @graph = Graph.find(params[:id])
    render :edit, layout: false
  end

  def update
    @graph = Graph.find(params[:id])
    if @graph.update(graph_params)
      redirect_to :action => "show", :id => @graph.id, :user_id => current_user.id
    else
      render 'edit'
    end
  end

  def destroy
    Graph.find(params[:id]).destroy
    redirect_to user_graphs_url
  end
  
  private

  def graph_params
    params.require(:graph).permit(:name, :data, :graph_json)
  end

  def add_breadcrumbs
    add_breadcrumb current_user.name, user_path(current_user)
    add_breadcrumb "Graphs", user_graphs_path(current_user)
  end

end
