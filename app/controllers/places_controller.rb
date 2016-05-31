class PlacesController < ApplicationController

	class Message
		attr_accessor :place
		attr_accessor :dist

	end

	layout "place"
	require 'socket'

	def show

		if current_user
			@user = current_user
		else
			@user = nil
		end

		@place = Place.find(params[:id])
		rate = RatingCache.where('cacheable_id=?', @place.id)
		if(rate.first != nil)
			@rating = rate.first.qty
		else
			@rating = 0
		end
	end

	def show_json

		if(params[:lat] == nil)
			@places = Place.all
			latlng = [0,0]

		else
			latlng = [params[:lat], params[:lng]]
			radius = params[:radius]
			@places = Place.within(radius,  :origin => latlng)
		end
		
		pt = Geokit::LatLng.new( params[:lat] ,params[:lng])
		@message = Array.new
		@places.each do |p|
			 m = Message.new
			 m.place = p
			 m.dist = p.distance_to(pt)
			 @message << m
		end

		render :json => @message
	end

	def index
		if current_user
			@user = current_user
		else
			@user = nil
		end

		@ratings = RatingCache.all
		@places = Place.all
		@host =  Socket.gethostname
	end

	def within
		latlng = [params[:lat], params[:lng]]
		radius = params[:radius]

		if radius == 0
			radius = 100
		end
		@places = Place.within(radius,  :origin => latlng)

	end

	def getPhotos
		@photos = Photo.where(:place_id => params[:id])
		render :json => @photos
	end

	def create
		@place = Place.create(place_params)
	end


	def destroy
	end

	def update
	end

	private
		def place_params
			params.require(:place).permit(:title, :description, :lat, :lng)
		end
end
