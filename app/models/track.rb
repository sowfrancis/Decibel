class Track < ActiveRecord::Base
  
  has_many :comments
  belongs_to :user
  has_many :votes
  has_many :tags, through: :taggings, :dependent => :destroy
  has_many :taggings
  has_many :notifications

  before_save :create_tag


  has_attached_file :avatar, 
                    default_url: "/images/:style/missing.png",
                    :storage => :s3,
                    :s3_credentials => {
                                  :bucket => ENV['S3_BUCKET_NAME'],
                                  :s3_region => ENV['AWS_REGION'],
                                  :access_key_id =>  ENV['AWS_ACCESS_KEY_ID'],
                                  :secret_access_key =>  ENV['AWS_SECRET_ACCESS_KEY'],
                                  :s3_host_name => 's3-website-us-east-1.amazonaws.com',
                                  :url => ":s3_domain_url",
                                  :path => '/:class/:attachment/:id_partition/:style/:filename'
                                 }
 
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
    tag_list = []
      tags.each do |tag|
        if tag == 1
          Tag.find(name: [:name])
        else
          tag_list << Tag.create(name: tag)
        end
      end
  end


end
