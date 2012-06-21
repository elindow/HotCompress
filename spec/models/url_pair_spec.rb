require 'spec_helper'

describe UrlPair do
  it { should validate_presence_of(:short_url) }
  it { should validate_uniqueness_of(:short_url) }
  it { should validate_presence_of(:long_url) }  
  it { should validate_presence_of(:user_id) } 
  it { should validate_presence_of(:hit_count) }  
  it { should belong_to(:user) }
end
