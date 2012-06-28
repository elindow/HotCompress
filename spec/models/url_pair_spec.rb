require 'spec_helper'

describe UrlPair do
  it { should validate_presence_of(:short_url) }
  it { should validate_presence_of(:long_url) }  
  it { should validate_presence_of(:user_id) } 
  it { should validate_presence_of(:hit_count) }  
  it { should belong_to(:user) }
  it "should only accept unique short_urls" do
	Fabricate(:url_pair)
	UrlPair.new.should validate_uniqueness_of( :short_url )
  end

	context "fabricators" do
		it "should be valid" do
			@urlp = Fabricate.build(:url_pair, :long_url => 'http://f.com', :short_url => 'f' )
			@urlp.long_url.should eq 'http://f.com'
			@urlp.short_url.should eq 'f'
			@urlp.hit_count.should eq 0
			@urlp.user_id.should eq 1
		end
	end
end