class Track < ActiveRecord::Base
  
  has_many :comments
  belongs_to :user
  has_many :votes
  has_many :tags, through: :taggings, :dependent => :destroy
  has_many :taggings


  has_attached_file :avatar, default_url: "/images/:style/missing.png"
  validates_attachment_content_type :avatar, :content_type => [ 'image/png','image/jpeg']

  has_attached_file :audio
  validates_attachment_presence :audio
  validates_attachment_content_type :audio, :content_type => [ 'audio/mp3','audio/mpeg']

  acts_as_votable 

  def score
    self.get_upvotes.size - self.get_downvotes.size
  end

  def self.search(search)
    where("audio_file_name LIKE ?", "%#{search}%")
  end


  acts_as_messageable


end
