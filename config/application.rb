# load libraries required on boot
require File.expand_path('../boot', __FILE__)

# the action controller that serves requests
require 'rails/all'

#other action controllers


# libraries required for the application to run
# include :default and current environment libraries
if defined?(Bundler)
	#puts "Bundler exists"
	Bundler.require :default, Rails.env
elsif
	puts "No Bundler"
end

# application itself
module HotCompress
	class Application < Rails::Application
		# Configure the default encoding used in templates for Ruby 1.9.
		config.encoding = "utf-8"
		config.active_support.deprecation = :log
		# Enable the asset pipeline
		config.assets.enabled = true
		#development?
		config.action_mailer.default_url_options = { :host => 'localhost:3000' }
		config.action_mailer.delivery_method = :smtp 
		config.action_mailer.smtp_settings = { 
		:address => "smtp.gmail.com", 
		:port => 587, 
		:domain => 'trevor.org', 
		:user_name => 'elindow@trevor.org', 
		:password => '2expect5', 
		:authentication => 'login', 
		:enable_starttls_auto => true } 
		#production would be actual host
		config.action_view.javascript_expansions[:defaults] = %w(jquery.min jquery_ujs)
	end
end



