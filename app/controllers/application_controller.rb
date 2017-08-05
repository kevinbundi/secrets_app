class ApplicationController < ActionController::Base
  	protect_from_forgery with: :exception

  	helper_method :current_user
 

	private
		def current_user
	 	    User.find(session[:user_id]) if session[:user_id]
	    end
		def require_login
		    redirect_to '/sessions/new' unless current_user
		end
		def logged_in
		    redirect_to '/secrets' if current_user
		end 
end

