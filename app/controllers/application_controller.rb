class ApplicationController < ActionController::Base
	protect_from_forgery
	
	def not_found
		#raise ActionController::RoutingError.new('Not Found')
		render :text => '404 Error - Not Found', :status => 404
	end
	
	def current_or_guest_user
		if current_user
			if session[:guest_user_id]
				logging_in
				guest_user.destroy
				session[:guest_user_id] = nil
			end
			@current_user = current_user
			@uid = current_user.id
			@guest_user = nil
		else
			@guest_user = guest_user
			@uid = guest_user.id		
		end
		puts "user id is #{@uid}"
	end
	
	# find guest_user object associated with the current session,
	# creating one as needed
	def guest_user
		guest_user = User.find_by_email("guest@e.com")
		if ( guest_user.nil? )
			create_guest_user
		end
		guest_user
		#User.find(session[:guest_user_id].nil? ? session[:guest_user_id] = create_guest_user.id : session[:guest_user_id])
	end
	
	private

	# called (once) when the user logs in, insert any code your application needs
	# to hand off from guest_user to current_user.	
	def logging_in
		# For example:
		# guest_comments = guest_user.comments.all
		# guest_comments.each do |comment|
			# comment.user_id = current_user.id
			# comment.save
		# end
	end
	
	def create_guest_user
		puts "attempting to create guest user"
		u = User.create(:name => "guest", :email => "guest@e.com")
		#u = User.create(:name => "guest", :email => "guest_#{Time.now.to_i}#{rand(99)}@example.com")
		u.skip_confirmation!
		u.save(:validate => false)
		u
	end
	
end