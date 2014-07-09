class CommentsController < ApplicationController
  load_and_authorize_resource :post
  load_and_authorize_resource
  load_and_authorize_resource :author, instance_name: :post_author, through: :post, parent: false

  def index
    head :ok
  end
end

