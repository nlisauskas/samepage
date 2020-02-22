class CommentsController < ApplicationController
before_action :find_commentable

    def new
      @comment = Comment.new
    end

    def create
      @comment = @commentable.comments.new comment_params
      if current_user
        @comment.user_id = current_user.id
      elsif current_contractor
        @comment.contractor_id = current_contractor.id
      end
      if @comment.save
        binding.pry
        UserMailer.with(comment: @comment, bid: Bid.find_by_id(params[:bid_id])).comment_notification.deliver_now
        redirect_back fallback_location: root_path, notice: 'Your comment was successfully posted!'
      else
        redirect_back fallback_location: root_path, notice: "Your comment wasn't posted!"
      end
    end

    private

    def comment_params
      params.require(:comment).permit(:body, :user_id, :contractor_id, :bid_id)
    end

    def find_commentable
      @commentable = Comment.find_by_id(params[:comment_id]) if params[:comment_id]
      @commentable = MaintenanceRequest.find_by_id(params[:maintenance_request_id]) if params[:maintenance_request_id]
      @commentable = Bid.find_by_id(params[:bid_id]) if params[:bid_id]
    end

end
