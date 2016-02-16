module ApplicationHelper

  def notif_count(user)
    user = current_user
    notifications = Notification.where(user_id: user).count
 end

  def find_email(user_id)
    User.find(user_id).email
  end

  def user_find(user_id)
    User.find(user_id)
  end

  def track_owner(user)
    current_user = Track.where(user_id: current_user)
  end
  
end
