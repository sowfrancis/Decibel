class Tag < ActiveRecord::Base
  has_many :tracks, through: :taggings, :dependent => :destroy
  has_many :taggings

  def self.search(search)
    where("name LIKE ?", "%#{search}%")
  end
end
