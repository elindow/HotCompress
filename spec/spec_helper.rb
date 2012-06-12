require 'rubygems'
require 'spork'

Spork.prefork do

	ENV["RAILS_ENV"] ||= 'test'

	require "rails/application"
	require File.expand_path("../../config/environment", __FILE__)
	require 'rspec/rails'
	
	require 'capybara/rspec'
	require 'capybara/rails'

	RSpec.configure do |config|
		config.mock_with :rspec
		config.expect_with :rspec
		config.after(:all) do
			p "All tests finished"
		end
	end

	[ "support/config/*.rb", "support/*.rb" ].each do |path|
		Dir["#{File.dirname(__FILE__)}/#{path}"].each do |file|
			require file
		end
	end
#end

Spork.each_run do
	[ "support/config/*.rb", "support/*.rb" ].each do |path|
		Dir["#{File.dirname(__FILE__)}/#{path}"].each do |file|
			require file
		end
	end
end

end
