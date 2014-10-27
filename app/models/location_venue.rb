class LocationVenue < ActiveRecord::Base
  belongs_to :cl_location

  geocoded_by :address
  after_validation :geocode
end
