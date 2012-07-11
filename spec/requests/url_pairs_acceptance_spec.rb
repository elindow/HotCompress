require "spec_helper"
#include Warden::Test::Helpers

#Chrome webdriver
#Capybara.register_driver :selenium do |app|
#@driver = Capybara::Selenium::Driver.new(app, :browser => :chrome)
#end

feature "Url Pairs Integrtion Test", :firebug => true do

  before(:all) do

  end

  after(:all) do

  end

  scenario "are displayed in a table" do
    #@u = Fabricate(:user)
    #sign_in(@u)
    #@uid  = @u.id
    #ApplicationController::guest_user
    url_pair = Fabricate(:url_pair)
    visit "/url_pairs"
    # wait = Selenium::WebDriver::Wait.new(:timeout => 100) # seconds
    #wait.until { driver.find_element(:tag_name => 'td' ) }
    page.should have_css "td", text: url_pair.long_url
    page.should have_css "td", text: url_pair.short_url
  end

  scenario "data can be shown" do
    url_pair = Fabricate(:url_pair)
    visit "/url_pairs/#{url_pair.id.to_s}"
    #page.should have_content url_pair.long_url
    page.should have_content url_pair.short_url
  end

  scenario "can be created" do
    visit "/url_pairs/new"
    fill_in "Long Url", :with => 'http://www.google/com'
    fill_in "Short Url", :with => 'go'
    click_on "Create UrlPair"
    UrlPair.count.should == 1
    UrlPair.last.long_url.should == 'http://www.google/com'
    UrlPair.last.short_url.should == 'go'
  end

  scenario "can be edited" do
    url_pair = Fabricate(:url_pair)
    visit "/url_pairs/#{url_pair.id.to_s}/edit"
    fill_in "Long Url", :with => 'edited long_url'
    fill_in "Short Url", :with => 'edited short_url'
    click_on "Update UrlPair"
    url_pair.reload.long_url.should == 'edited long_url'
    url_pair.reload.short_url.should == 'edited short_url'
  end

=begin
  scenario "can be destroyed"  do
    url_pair = Fabricate(:url_pair)
    visit "/url_pairs"
    page.driver.browser.switch_to.alert.accept					#didn't work
    page.driver.browser.confirm(true) {browser.button.click}	#ditto
    click_link "Destroy"
    #alert = page.driver.switchTo().alert()						#ditto
    #alert.getText()											#ditto
    #alert.accept												#ditto
  end
=end

  scenario "can be destroyed" do
    url_pair = Fabricate(:url_pair)
    visit "/url_pairs"
    page.evaluate_script('window.confirm = function() { return true; }')
    click_link "Destroy"
    UrlPair.count.should == 0
  end

  scenario "doesn't exist" do
    visit "/url_pairs/-1"
    page.should have_content "404 Error - Not Found"
  end

end
