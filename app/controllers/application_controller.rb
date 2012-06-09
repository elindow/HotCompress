class ApplicationController < ActionController::Base
	protect_from_forgery
	
	def not_found
		#raise ActionController::RoutingError.new('Not Found')
		render :text => '404 Error - Not Found', :status => 404
	end
end