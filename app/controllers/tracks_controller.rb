class TracksController < ApplicationController
  before_action :authenticate_user!, except: :index
  SEND_FILE_METHOD = :default

  def index
    @tracks = Track.includes(:comments, :tags)
    @comment = Comment.new
    if(params[:search])
      @tracks = Track.search(params[:search]).order('created_at DESC')
    else
      @tracks = Track.all.order('created_at DESC')
    end
  end

  def new
    @track = Track.new
    @tag = Tag.new
  end

  def profile_track
    @tracks = Track.where(user_id: current_user).all
    @comment = Comment.new
  end

  def create
    @track = current_user.tracks.new(track_params)
    if @track.save
      redirect_to tracks_path, notice: "thanks #{@track.user.email} for your upload!"
    else
      render 'new'
    end
  end

  def search
  end


  def destroy
    @track = Track.find(params[:id])
    @track.destroy
    redirect_to tracks_path
  end

  def show
    @track = Track.find(params[:id])
    @comments = @track.comments.all
  end

  def upvote
    @track = Track.find(params[:id])
    @track.upvote_by current_user
    redirect_to tracks_path
  end


  private

  def track_params
    params.require(:track).permit(:avatar, :audio, :user_id)
  end
end
