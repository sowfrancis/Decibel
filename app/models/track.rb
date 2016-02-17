class Track < ActiveRecord::Base
  
  has_many :comments
  belongs_to :user
  has_many :votes
  has_many :tags, through: :taggings, :dependent => :destroy
  has_many :taggings
  has_many :notifications

  before_save :create_tag


  has_attached_file :avatar, default_url: "/images/:style/missing.png"
  validates_attachment_content_type :avatar, :content_type => [ 'image/png','image/jpeg']

  has_attached_file :audio
  validates_attachment_presence :audio
  validates_attachment_content_type :audio, :content_type => [ 'audio/mp3','audio/mpeg']

  acts_as_votable 

  acts_as_messageable

  def score
    self.get_upvotes.size - self.get_downvotes.size
  end

  def self.search(search)
    search = self.joins(:tags)
    search.where('tags.name ILIKE ?', "%#{search}%")
    where('audio_file_name ILIKE ?',"%#{search}%")
  end



  def create_tag
    tags = Tag.all
    tags_list = []
    tags.split(",").map do |tag|
      Tag.find_or_create_by(name: tag)
    end
    tags_list << tags
  end


end
