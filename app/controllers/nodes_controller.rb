class NodesController < ApplicationController

  def new(node_hash)
    name = node_hash["name"]
    group = node_hash["group"]
    @node = Node.new(name, group)
    render :new, layout: false
  end

  def create
    @node = node.create( node_params )
  end

  def destroy
    Node.find(params[:id]).destroy
  end

  private

  def node_params
    params.require(:node).permit(:name, :group)
  end

end
