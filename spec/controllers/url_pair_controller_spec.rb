require 'spec_helper'

describe UrlPairsController do

  describe "GET 'index'" do
		@user = Fabricate(:user)
		@up = Fabricate(:url_pair, :user_id => @user.id)		
		@url_pairs = UrlPair.find(:all)
		it "returns http success" do	
			get 'index'
			response.should be_success
		end
  end

  describe "GET 'show'" do
    it "returns http success" do  	
	  @user = Fabricate(:user)
	  @url_pair = Fabricate(:url_pair, :user_id => @user.id )
	  @url_pair.should be_valid
    end
  end

  describe "GET 'new'" do
		it "can be created with a name" do
			u = UrlPair.new({long_url: "http://www.test.com", short_url: "t", user_id: 1 })
			u.hit_count = 0
			#puts "u: #{u.long_url},#{u.short_url},#{u.hit_count},#{u.user_id}"
			u.should be_valid
		end
		it "cannot be created without a name" do
			UrlPair.new.should_not be_valid
		end
  end

  describe "GET 'edit'" do
	before(:each) do

	end	    
	it "can find a urlpair to be edited" do
		@url_pair = Fabricate(:url_pair)
		@url_pair.save
		#puts "url_pair #{@url_pair.user_id}, #{@url_pair.id}"
		@url_pair.id.should eq UrlPair.find(@url_pair.id).id
	end
  end

  describe "GET 'create'" do
    it "returns http success" do
      get 'create'
      response.should be_success
    end
  end

  describe "PUT 'update'" do
		before(:each) do

		end
		it "updates url_pair" do
			@url_pair = Fabricate(:url_pair)		
			put :update, :id => @url_pair.id.to_s, :url_pair => { :long_url => 'updated' }
			@url_pair.save
			@url_pair.reload.long_url.should == 'updated'
		end
  end

  describe "DELETE 'destroy'" do
	before(:each) do
		@url_pair = Fabricate(:url_pair)
	end
	it "can delete a url_pair" do 
		@url_pair.destroy
		@url_pair.should be_destroyed
	end
  end

#describe "url_pair doesn't exist" do
#	before do
#		get :show, :url_pair => 'none'
#	end
#		it { should_not assign_to :url_pair }
#		it { should_not render_template :show }
#		it { should respond_with :not_found }
#		it { should respond_with_content_type :html }
#	end
  
end
