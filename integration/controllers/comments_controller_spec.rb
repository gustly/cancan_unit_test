require 'integration_helper'

describe CommentsController do

  context "stubbing with incorrect resource instance or collection" do
    let_double(:post_object)
    let_double(:post_id)
    let_double(:post_author)
    let_double(:comments)

    before do
      stub_load_and_authorize_singleton_resource(:post) { post_object }
      stub_load_and_authorize_collection_resource(:comment) { comments }
      stub_load_and_authorize_singleton_resource(:author, instance_name: :post_author, through: :post, parent: false) { post_author }
    end

    describe "index" do
      it "assigns the post" do
        get :index, post_id: post_id
        assigns(:post).should == post_object
      end

      it "assigns the comments" do
        get :index, post_id: post_id
        assigns(:comments).should == comments
      end

      it "assigns the post's author" do
        get :index, post_id: post_id
        assigns(:post_author).should == post_author
      end
    end
  end
end
