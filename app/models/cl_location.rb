class ClLocation < ActiveRecord::Base
  belongs_to :cl_property

  reverse_geocoded_by :latitude, :longitude, :address => :geocoded_address
  after_validation :reverse_geocode
end
