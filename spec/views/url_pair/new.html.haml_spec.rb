require 'spec_helper'

describe "url_pairs/new.html.haml" do
  include Devise::TestHelpers
	
  before(:each) do
	u = Fabricate(:user)
	@uid  = u.id
    assign(:url_pair, Fabricate(:url_pair))
  end

  it "renders new url_pair form" do
    render
	assert_select "form", action: url_pair_path(:url_pair), method: "post" do
		assert_select "input#url_pair_long_url", :long_url => "url_pair[long_url]"	
	end
  end
end
