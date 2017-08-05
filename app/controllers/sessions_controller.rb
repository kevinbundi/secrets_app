class SessionsController < ApplicationController
  skip_before_action :require_login, except: [:destroy]
  before_action :logged_in, only: [:new]
  
	def new
	end

	def create
		user = User.find_by_username(params[:session][:username])
		if params[:session][:username] == ""
			flash[:danger] = "Username can't be blank"
			redirect_to new_session_path
		elsif params[:session][:password] == ""
			flash[:danger] = "Password can't be blank"
			redirect_to new_session_path
		elsif !user
      		flash[:danger] = "username not found"
      		redirect_to new_session_path 
    	elsif !user.authenticate(params[:session][:password])
      		flash[:danger] = "wrong password"
      		redirect_to new_session_path
      	else
      		session[:user_id] = user.id
      		flash[:success] = "Welcome #{current_user.username}"
      		redirect_to secrets_path
      	end
	end 

	def destroy
  		session[:user_id] = nil
  		flash[:success] = "you have signed out"
  		redirect_to new_session_path
  	end
end
