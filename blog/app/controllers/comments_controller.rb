class CommentsController < ApplicationController
  before_action :find_commentable

  def new
    @comment = Comment.new
  end

  def create
    @comment = @commentable.comments.new comment_params

    if @comment.save
      redirect_to :back, notice: 'Your comment was successfully posted!'
    else
      redirect_to :back, notice: "Your comment wasn't posted!"
    end
  end

  def comment_params
    params.require(:comment).permit(:body)
  end
  private :comment_params

  def find_commentable
    if params[:comment_id]
      @commentable = Comment.find(params[:comment_id])
    end
    if params[:post_id]
      @commentable = Post.find(params[:post_id])
    end
  end
  private :find_commentable
end
