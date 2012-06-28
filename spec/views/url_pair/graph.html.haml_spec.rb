require 'spec_helper'

describe "url_pairs/graph.html.haml", :js => true do
    include Devise::TestHelpers

 	before(:each) do
		@u = Fabricate(:user)
		sign_in @u
		@uid  = @u.id
		@url_pair = Fabricate(:url_pair)
		assign(:url_pairs, UrlPair.all)
	end
	it "renders a graph of all url_pairs" do
		#visit "url_pairs/graph.html.haml"
		#render
		#assert_select "high_chart", :options[:title][:text] => "Url Pairs Graph"
	end
end
