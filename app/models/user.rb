class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :comments
  has_many :tracks
  has_many :votes
  has_many :notifications, :foreign_key => "user_id"



  has_attached_file :avatar, styles: { medium: "300x300>", thumb: "100x100>" }, 
                    default_url: "/images/:style/missing.png",
                    :storage => :s3,
                    :s3_credentials => {
                      :bucket => ENV['S3_BUCKET_NAME'],
                      :s3_region => ENV['AWS_REGION'],
                      :access_key_id => ENV['AWS_ACCESS_KEY_ID'],
                      :secret_access_key => ENV['AWS_SECRET_ACCESS_KEY'],
                      :url => ":s3_domain_url",
                      :path => '/:class/:attachment/:id_partition/:style/:filename'
                    }


  validates_attachment_content_type :avatar, :content_type => /.*/

  acts_as_messageable



    #Returning any kind of identification you want for the model
  def name
    
  end

  #Returning the email address of the model if an email should be sent for this object (Message or Notification).
  #If no mail has to be sent, return nil.
  def mailboxer_email(object)
    #Check if an email should be sent for that object
    #if true
    return "define_email@on_your.model"
    #if false
    #return nil
  end

 
end
