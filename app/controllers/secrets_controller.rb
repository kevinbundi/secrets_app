class SecretsController < ApplicationController
	before_action :require_login
	before_action :all_tasks, only: [:index, :create, :update, :destroy]

  	def index
  		@secrets = Secret.all.reverse
  	end

  	def create
  		@secret = Secret.new(content: secret_params['content'], user: current_user)	
  		if @secret.valid? == true
  			@secret.save
        
		    respond_to do |format|
		        format.html { redirect_to root_path }
				format.js { }
		    end
  		else
	  		flash[:secret_errors] = @secret.errors.full_messages 
	  		redirect_to '/'
	  	end
  	end

	def edit
		@secret = Secret.find(params[:id])
		respond_to do |format|
			format.html { }
			format.js { }
		end
	end

	def update
		@user_secrets = Secret.where(user: current_user)
		secret = Secret.update params[:id], content: secret_params[:content]
	    if secret.save
	    	flash[:success] = "Secret updated"
	        respond_to do |format|
	        	format.html { redirect_to user_path }
	        	format.js {}
	        end
	    else
	      flash[:danger] = secret.errors.full_messages
	      redirect_to edit_secret_path
	    end
	end

	def destroy
		# make this instance variable available to the partial
		@user_secrets = Secret.where(user: current_user)
		@secret = Secret.find(params[:id])
		@secret.destroy
	    respond_to do |format|
	    	format.html { redirect_to :back }
	    	format.js { }
	    end
	end

	private
		def secret_params
			params.require(:secret).permit(:content)
		end
		def all_tasks
			@secrets = Secret.all
		end
end
