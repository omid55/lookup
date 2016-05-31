module PlacesHelper
def reviews(place)
    RatingCache.where(cached_id)
  end
end
