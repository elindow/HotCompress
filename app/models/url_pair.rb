class UrlPair < ActiveRecord::Base
  attr_accessible :long_url, :short_url, :user_id
  
  validates_presence_of :short_url
  validates_uniqueness_of :short_url, :case_sensitive => true#, :scope => [:user_id]
  validates_presence_of :long_url
  validates_presence_of :user_id
  validates_presence_of :hit_count
  
  belongs_to :user
end
