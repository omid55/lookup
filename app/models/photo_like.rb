class PhotoLike < ActiveRecord::Base

	belongs_to :user
	belongs_to :liked_photo, :class_name => "Photo"

end
