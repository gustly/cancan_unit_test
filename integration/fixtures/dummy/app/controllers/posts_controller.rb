class PostsController < ApplicationController
  load_and_authorize_resource :post

  def create
    render :index
  end

end
