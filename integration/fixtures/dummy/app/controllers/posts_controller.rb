class PostsController < ApplicationController
  load_and_authorize_resource :post, except: [:index]
  load_resource :post, only: [:index]

  def create
    render :index
  end

  def index
  end
end
