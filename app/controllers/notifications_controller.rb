class NotificationsController < ApplicationController
  
  def index
    @track = Track.all
    @notifications = Notification.where(user_id: current_user).all
    @notifications.each do |notification|
      notification.update_attribute(:check, true)
    end
  end

  def new
    @notification = Notification.new
  end

  def destroy
    @notification = Notification.find(params[:id])
    @notification.destroy
    redirect_to notifications_path
  end

  def create
    @notification = notification.create_notfication
  end



  private

  def comment_params
    params.require(:notification).permit(:user_id, :comment_id, :message_id)
  end
end
