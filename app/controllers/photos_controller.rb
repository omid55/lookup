class PhotosController < ApplicationController

	before_action :authenticate_user!

	layout 'photo'

	def new
		@user = current_user
		@photo = Photo.new
	end

	def create
		if current_user
			user = current_user
			@photo = Photo.create(photo_params)
			radius = 100
			places = Place.within( radius, :origin => [ params[:lat], params[:lng] ])
			done = false

			places.each do |place|
				if place.title == params[:title]
					place.photos << @photo
					user.photos << @photo
					done = true
					break
				end
			end


			if( done == false )

				place = Place.create({:title => params[:title], :lat => params[:lat], :lng => params[:lng]})
				place.photos << @photo
				user.photos << @photo

			end

			if @photo.save
				redirect_to ({:controller => 'places', :action => 'index'})
			else
				render('new')
			end
		else
			 redirect_to login_path
		end
	end

	private

		def photo_params
			params.require(:photo).permit(:title, :description, :image, :lat, :lng)
		end
end
