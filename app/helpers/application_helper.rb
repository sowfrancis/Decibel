module ApplicationHelper

  def notif_count(user)
    @user = current_user
    @notifications = Notification.where(user_id: @user).count(check: false)
 end

 
  
end
