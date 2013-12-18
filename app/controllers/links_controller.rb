class LinksController < ApplicationController

  def new(link_hash)
    source = link_hash["source"]
    target = link_hash["target"]
    value = link_hash["value"]
    @link = Link.new(source, target, value, checked)
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
