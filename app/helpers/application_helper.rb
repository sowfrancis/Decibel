module ApplicationHelper

  def notif_count(user)
    user = current_user
    notifications = Notification.where(user_id: user).count
 end

  def find_email(user_id)
    User.find(user_id).email
  end

  def track_owner(user)
    current_user = Track.where(user_id: current_user)
  end

  def bootstrap_flash
    if :notice
      "alert-warning"
    else

    end
  end
  
  def current_user
    if cookies[:remember_token].present?
      @current_user ||= User.find_by_remember_token(cookies[:remember_token])
    end
  end


end
