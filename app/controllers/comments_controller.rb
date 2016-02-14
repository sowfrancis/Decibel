class CommentsController < ApplicationController

  def index
    @comments = Comment.all
  end

  def new
    @comment = Comment.new
   
  end

  def create
     @comment = Comment.new(params_comment)
    if @comment.save
      redirect_to track_path(@comment.track.id), notice: "thanks #{@comment.user.email} for your posting"
    else
      redirect_to tracks_path, notice: "erreur"
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
