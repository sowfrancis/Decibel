class Comment < ActiveRecord::Base
  belongs_to :user 
  belongs_to :track
  has_many :notifications

  before_save :send_notification

  def send_notification
    if user == track_owner
      
    else
      create_notif 
    end
  end

  def create_notif
    Notification.create(user_id: track_owner.id,
                      comment_id: self.user.id,
                      track_id: track.id,
                      content: "Vous avez recu un commentaire!"
                    )
  end
  
  def track_owner
    user = track.user
  end
end
