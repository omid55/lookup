class Tag < ActiveRecord::Base
	has_many :places_tags
	has_many :places, through: :places_tags
end
