class AddTrackToNotification < ActiveRecord::Migration
  def change
    add_reference :notifications, :track, index: true, foreign_key: true
  end
end
