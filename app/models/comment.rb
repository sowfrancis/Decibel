class Comment < ActiveRecord::Base
  belongs_to :user 
  belongs_to :track
  has_many :notifications

  before_save :send_notification

  def send_notification
    if comment_owner == track_owner

    else
      Notification.create(user_id: track.user.id,
                         comment_id: self.user.id,
                         track_id: track.id,
                         content: "Vous avez recu un commentaire!"
                         ) unless user == track_owner
    end
  end
  
  def track_owner
    user = track.user
  end

  def comment_owner
    user = self.user
  end
end
