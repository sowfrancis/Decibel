class CommentsController < ApplicationController

  def index
    @comments = Comment.all
  end

  def new
    @comment = Comment.new
   
  end

  def create
     @comment = current_user.comments.new(params_comment)
    if @comment.save
      redirect_to track_path(@comment.track_id), notice: "thanks #{@comment.user.firstname} #{@comment.user.lastname} for your posting!!"
    else
      redirect_to tracks_path, notice: "error! Please try to post a another comment."
    end
  end

  def show
    @comment = Comment.find(params[:id])
  end

  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy
    redirect_to track_path(@comment.track.id)
  end

  private

  def params_comment
    params.require(:comment).permit(:content, :user_id, :track_id)
  end
end
