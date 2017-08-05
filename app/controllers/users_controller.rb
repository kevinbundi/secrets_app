class UsersController < ApplicationController
    before_action :require_login, except: [:new, :create]
    before_action :all_tasks, only: [:show]
	# respond_to :html, :js

  	def index
  	end

  	def create
  		user = User.create(register_params)
  		if user.valid? == true
  			user.save
  			flash[:success] = "Registration successful" 
  			redirect_to new_session_path 
  		else
  			flash[:danger] = user.errors.full_messages
  			redirect_to new_user_path
      	end
  	end

  	def new
  		@user = User.new
 	end

    def show
       @user = User.find(session[:user_id]) 
       @user_secrets = Secret.where(user: current_user).reverse
       # @secrets_liked = current_user.secrets_liked.reverse
    end

    def edit
        @user = User.find(current_user)
        respond_to do |format|
            format.html { }
            format.js { }
        end
    end

    def update
        @user = User.update params[:id], update_params 
        if @user.save
            flash[:success] = "username updated"
            respond_to do |format|
                format.html { redirect_to user_path }
                format.js { }
            end
        else
            flash[:danger] = @user.errors.full_messages
            redirect_to edit_user_path
        end
    end

 	private
 		def register_params
 			params.require(:user).permit(:username, :email, :password, :password_confirmation)
 		end

        def update_params
            params.require(:user).permit(:username)
        end

        def all_tasks
            @secrets = Secret.all
        end
end
