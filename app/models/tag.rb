class Tag < ActiveRecord::Base
  has_many :tracks, through: :taggings, :dependent => :destroy
  has_many :taggings
end
