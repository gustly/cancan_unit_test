class PostsController < ApplicationController
  load_and_authorize_resource

  def create
    render :index
  end

end
