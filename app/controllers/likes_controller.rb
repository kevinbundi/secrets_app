class LikesController < ApplicationController
	before_action :all_tasks, only: [:create, :destroy]

	def create
		like = Like.new(secret: Secret.find(params[:id]), user: current_user)
	  	like.save
		respond_to do |format|
	  		format.html { redirect_to root_path }
	  		format.js { }
	  	end
	end

	def destroy
		likes = Like.where(user: current_user, secret: Secret.find(params[:id]))
	    likes.each{ |like| like.destroy } 
	  	respond_to do |format|
	  		format.html { redirect_to root_path }
	  		format.js { }
	  	end
	end

	private
		def all_tasks
			@secrets = Secret.all.reverse
			@comments = Comment.all
			# @likes = Like.all
		end
end
