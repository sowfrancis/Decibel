class AddAttachmentAvatarToTracks < ActiveRecord::Migration
  def self.up
    change_table :tracks do |t|
      t.attachment :avatar
    end
  end

  def self.down
    remove_attachment :tracks, :avatar
  end
end
