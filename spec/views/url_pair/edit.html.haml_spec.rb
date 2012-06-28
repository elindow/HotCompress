require 'spec_helper'

describe "url_pairs/edit.html.haml" do
    include Devise::TestHelpers

	before(:each) do
		@u = Fabricate(:user)
		sign_in @u
		@uid  = @u.id
		@url_pair = Fabricate(:url_pair)
		assign(:url_pairs, UrlPair.all)
	end
	it "renders an edit form" do
		render
		assert_select "form", action: url_pair_path(@url_pair), method: "post" do
			assert_select "input#url_pair_long_url", :long_url => "url_pair[long_url]"	
		end	
	end
end
