class Comment < ActiveRecord::Base
  belongs_to :user 
  belongs_to :track
  has_many :notifications

  before_save :send_notification

  def send_notification
    Notification.create(user_id: track.user.id,
                       comment_id: self.track.id,
                       track_id: track_id,
                       content: "Vous avez recu un commentaire!"
                       )
  end
  
 
end
