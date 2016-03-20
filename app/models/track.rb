class Track < ActiveRecord::Base
  
  has_many :comments
  belongs_to :user
  has_many :votes
  has_many :tags, through: :taggings, :dependent => :destroy
  has_many :taggings
  has_many :notifications

  #before_save :create_tag

  acts_as_votable 
  acts_as_messageable
  
  has_attached_file :avatar, 
                      :storage => :filesystem,
                      default_url: "/images/:style/missing.png",
                      :path => ":rails_root/public/system/:class/:attachment/:id/:style/:basename.:extension",
                      :url => '/system/:class/:attachment/:id/:style/:basename.:extension'
  unless Rails.env.production?
    has_attached_file :avatar,
                      :storage => :s3,
                      :bucket => ENV['S3_BUCKET_NAME'],
                      :s3_region => ENV['AWS_REGION'],
                      :s3_credentials => "#{Rails.root}/config/s3.yml",
                      :url => ":s3_domain_url",
                      :path => '/:class/:attachment/:id_partition/:style/:filename'
  end
 
  validates_attachment_content_type :avatar, :content_type => [ 'image/png','image/jpeg']

  has_attached_file :audio
  validates_attachment_presence :audio
  validates_attachment_content_type :audio, :content_type => [ 'audio/mp3','audio/mpeg']


  def score
    self.get_upvotes.size - self.get_downvotes.size
  end

  def self.search(search)
    search = self.joins(:tags)
    search.where('tags.name ILIKE ?', "%#{search}%")
    where('audio_file_name ILIKE ?',"%#{search}%")
  end



  #def create_tag
  #  @tags_array = []
  #  @tags = Tag.all
 #   @tag = self.tags.new params[:tag]
  #  @tags_array.map do |tag|
  #    if tag == 1
  #      Tag.find(tag)
  #    else
  #      @tags_array << Tag.create(name: tag)
  #    end
  #  end
  #end


end