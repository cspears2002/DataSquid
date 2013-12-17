class LinksController < ApplicationController

  def new(src_node, target_node, value)
    @link = Link.new(src_node, target_node, value)
    render :new, layout: false
  end

  def create
    @link = link.create( link_params )
  end

  private

  def link_params
    params.require(:link).permit(:value)
  end
end
