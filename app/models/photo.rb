class Photo < ActiveRecord::Base

	belongs_to :user
	belongs_to :place
	has_many :comments
	has_many :likes, :class_name => "PhotoLike"

	has_attached_file :image
	validates_attachment_content_type :image, content_type: /\Aimage\/.*\Z/
	
end
