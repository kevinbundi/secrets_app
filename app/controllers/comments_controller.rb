class CommentsController < ApplicationController
	before_action :all_tasks, only: [:index, :create, :update, :destroy]

	def create
		comment = Comment.create(user: current_user, secret: Secret.find(comment_params[:id]), content: comment_params[:content])
		if comment.valid?
			comment.save
			# flash[:secret_comment_success] = "Comment added"

			respond_to do |format|
				format.html{ redirect_to root_path }
				format.js { }
			end
		else
			flash[:secret_comment_error] = comment.errors.full_messages
			redirect_to '/'
		end
	end
	private
		def comment_params
			params.require(:comment).permit(:content, :id)
		end
		def all_tasks
			@comments = Comment.all
			@secrets = Secret.all.reverse
		end
end
