require 'spec_helper'
require "selenium-webdriver"

describe "url_pairs/graph.html.haml" do
    include Devise::TestHelpers

 	before(:each) do

	end
	it "renders a graph of all url_pairs" do
		@u = Fabricate(:user)
		sign_in @u
		@uid  = @u.id
		@url_pair = Fabricate(:url_pair)
		assign(:url_pairs, UrlPair.all)
		y @h
		render
		response.should be_success	
	end
end
