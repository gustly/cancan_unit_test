require 'spec_integration_helper'

describe PostsController do
  context "not stubbing" do
    it "uses can can" do
      post :create
      assigns(:post).should be_a Post
    end
  end

  context "stubbing load and authorize with a singleton" do
    let_double(:article)

    before do
      stub_load_and_authorize_singleton_resource(:post) { article }
    end

    it "uses the stub" do
      post :create
      assigns(:post).should == article
    end
  end

  context "stub load resource with a singleton" do
    let_double(:post)

    before do
      stub_load_singleton_resource(:post) { post }
    end

    it "uses the stub" do
      get :index
      assigns(:post).should == post
    end
  end

  context "stubbing with load_and_authorize_resource incorrect matchers" do
    let_double(:article)

    before do
      stub_load_and_authorize_singleton_resource(:post, instance_method: :i_am_not_right) { article }
    end

    context "and warnings turned on", cancan_unit_test_warning: true do
      it "warns that there was no stub found" do
        STDOUT.should_receive(:puts).with("\e[33mCancanUnitTest Warning:\e[0m no stub found for 'load_and_authorize_resource :post'")
        post :create
      end
    end

    context "and warnings defaulting to off" do
      it "warns that there was no stub found" do
        STDOUT.should_not_receive(:puts).with("\e[33mCancanUnitTest Warning:\e[0m no stub found for 'load_and_authorize_resource :post'")
        post :create
      end
    end
  end

  context "stubbing load resource with incorrect matchers" do
    let_double(:post)

    before do
      stub_load_singleton_resource(:author, instance_method: :i_am_not_right) { post }
    end

    context "and warnings turned on", cancan_unit_test_warning: true do
      it "warns that there was no stub found" do
        STDOUT.should_receive(:puts).with("\e[33mCancanUnitTest Warning:\e[0m no stub found for 'load_resource :post'")
        get :index
      end
    end

    context "and warnings defaulting to off" do
      it "warns that there was no stub found" do
        STDOUT.should_not_receive(:puts).with("\e[33mCancanUnitTest Warning:\e[0m no stub found for 'load_resource :post'")
        get :index
      end
    end
  end
end
