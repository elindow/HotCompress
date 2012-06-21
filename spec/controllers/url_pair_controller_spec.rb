require 'spec_helper'

describe UrlPairsController do
  describe "GET 'index'" do
		@user = Fabricate(:user)
		@up = Fabricate(:url_pair, :user_id => @user.id)		
		#@up.user = @user
		@url_pairs = UrlPair.find(:all)
		it "returns http success" do	
			get 'index'
			response.should be_success
		end
  end

  describe "GET 'show'" do
  	@user = Fabricate(:user)
	@url_pair = Fabricate(:url_pair, :user_id => @user.id )
    it "returns http success" do
      get 'show\url_pair.id'
      response.should be_success
    end
  end

  describe "GET 'new'" do
    it "returns http success" do
      get 'new'
      response.should be_success
    end
  end

  describe "GET 'edit'" do
	before(:each) do
		@user = Fabricate(:user)
		@url_pair = Fabricate(:url_pair)
		@url_pair << @user
	end	    
	it "returns http success" do
      get 'edit'
      response.should be_success
    end
  end

  describe "GET 'create'" do
    it "returns http success" do
      get 'create'
      response.should be_success
    end
  end

  describe "GET 'update'" do
    it "returns http success" do
      get 'update'
      response.should be_success
    end
  end

  describe "GET 'destroy'" do
    it "returns http success" do
      get 'destroy'
      response.should be_success
    end
  end

end
