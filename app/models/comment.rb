class Comment < ActiveRecord::Base
  belongs_to :user 
  belongs_to :track
  has_many :notifications

  before_save :send_notification

  def send_notification
    Notification.create(user_id: track.user.id,
                       comment_id: track.comments.last,
                       content: "Vous avez recu un commentaire!"
                       )

  end
  
  
 
end
