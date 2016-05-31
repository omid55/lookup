class Place < ActiveRecord::Base

	has_many :places_tags
	has_many :tags, through: :places_tags
	has_many :photos
	has_many :reviews

	ratyrate_rateable "rating"

	acts_as_mappable :default_units => :miles,
                   :default_formula => :sphere,
                   :distance_field_name => :distance,
                   :lat_column_name => :lat,
                   :lng_column_name => :lng
                   
end
