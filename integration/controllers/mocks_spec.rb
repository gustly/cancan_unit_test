require 'integration_helper'

describe PostsController do

  context "not stubbing" do
    it "uses can can" do
      post :create
      assigns[:post].should be_a Post
    end
  end

  context "stubbing" do
    let_double(:article)

    before do
      stub_load_and_authorize_resource(:post) { article }
    end

    it "uses the stub" do
      post :create
      assigns[:post].should == article
    end
  end

end
