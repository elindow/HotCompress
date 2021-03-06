require 'spec_helper'

describe "url_pairs/show.html.haml" do
    include Devise::TestHelpers
	
	before(:each) do
		@u = Fabricate(:user)
		sign_in @u
		@uid  = @u.id
		@url_pair = Fabricate(:url_pair)
		assign(:url_pairs, UrlPair.all)
	end
	it "renders a list of url_pair fields" do
		render
		assert_select "li", 3
	end
end
