class ClLocation < ActiveRecord::Base
  belongs_to :cl_property
  has_many :location_scores
  has_many :location_venues

  reverse_geocoded_by :latitude, :longitude, :address => :geocoded_address
  after_validation :reverse_geocode
  after_save :score

  private
    def grocery_score
      require 'yelp'
      client = Yelp::Client.new({
        consumer_key: ENV["YELP_CONSUMER_KEY"],
        consumer_secret: ENV["YELP_CONSUMER_SECRET"],
        token: ENV["YELP_TOKEN"],
        token_secret: ENV["YELP_TOKEN_SECRET"]
      })

      coordinates = {
        latitude: self.latitude,
        longitude: self.longitude
      }

      params = {
        category_filter: 'grocery',
        limit: 3,
        sort: 1 # sort by distance
      }

      result = client.search_by_coordinates(coordinates, params)

      for bus in result.businesses
        external_url = bus.url rescue nil
        external_image_url = bus.image_url rescue nil
        phone = bus.phone rescue nil

        self.location_venues.create!(
          name: bus.name,
          address: bus.location.display_address,
          rating: bus.rating,
          external_id: bus.id,
          external_url: external_url,
          external_image_url: external_image_url,
          phone: phone,
          distance: bus.distance,
          category: "grocery",
          source: "yelp"
        )
      end
    end

    def score
      grocery_score()
      puts "Full score finished."
    end
end
