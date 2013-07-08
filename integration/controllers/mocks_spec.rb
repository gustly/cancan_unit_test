require 'integration_helper'
describe PostsController do

  before do
    post :create
  end

  context "not stubbing" do
    it "uses can can" do
      assigns[:post].should be_a Post
    end
  end

  context "stubbing" do
    let_double(:article)

    it "uses the stub" do
      assigns[:post].should == article
    end
  end

end
