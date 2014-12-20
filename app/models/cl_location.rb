class ClLocation < ActiveRecord::Base
  belongs_to :cl_property
  has_many :location_scores, dependent: :destroy
  has_many :location_venues, dependent: :destroy

  reverse_geocoded_by :latitude, :longitude, :address => :geocoded_address
  after_validation :reverse_geocode
  after_save :score

  private
    # speeds all in seconds / meter
    # average people walk ~.722 seconds/meter
    WALKING_SPEED = 0.722

    # average people cycle ~.25 seconds/meter
    BIKING_SPEED = 0.25

    # 25mph ~= .89 seconds/meter
    # Since we're sorting by location, most venues should be pretty close.
    # So, ~25mph is a reasonable assumption
    DRIVING_SPEED = 0.089

    def specific_score(cat, limit, count_rating, yelp_client)
      coordinates = {
        latitude: self.latitude,
        longitude: self.longitude
      }

      params = {
        category_filter: cat,
        limit: limit,
        sort: 1 # sort by distance
      }

      result = yelp_client.search_by_coordinates(coordinates, params)

      # add to LocationVenues
      for bus in result.businesses
        external_url = bus.url rescue nil
        external_image_url = bus.image_url rescue nil
        phone = bus.phone rescue nil

        walk_time = (60 + 1.5 * (WALKING_SPEED * bus.distance)).to_i

        bike_time = (60 + 1.5 * (BIKING_SPEED * bus.distance)).to_i

        # But, driving has a 180 second fixed cost, due to parking
        drive_time = (180 + 2 * (DRIVING_SPEED * bus.distance)).to_i

        self.location_venues.create!(
          name: bus.name,
          address: bus.location.display_address.join(", "), # join all parts with commas
          rating: bus.rating,
          external_id: bus.id,
          external_url: external_url,
          external_image_url: external_image_url,
          phone: phone,
          distance: bus.distance, # in meters
          walk_time: walk_time,
          bike_time: bike_time,
          drive_time: drive_time,
          category: cat,
          source: 'yelp'
        )
      end

      location_venues = self.location_venues.where(category: cat);
      if location_venues.length != 0
        min_walk_time = location_venues.minimum(:walk_time) / 60
        min_bike_time = location_venues.minimum(:bike_time) / 60
        min_drive_time = location_venues.minimum(:drive_time) / 60

        score = self.location_scores.new(
          walk_score: (time = 100 - 4 * min_walk_time) < 0 ? 0 : time,
          bike_score: (time = 100 - 4 * min_bike_time) < 0 ? 0 : time,
          drive_score: (time = 100 - 4 * min_drive_time) < 0 ? 0 : time,
          category: cat
        )

        if count_rating
          average_rating = location_venues.where(category: "restaurants").average(:rating).to_f
          score.walk_score = score.walk_score / 2 + 10 * average_rating
          score.bike_score = score.bike_score / 2 + 10 * average_rating
          score.drive_score = score.drive_score / 2 + 10 * average_rating
        end

        score.save!

      else
        puts "I has broke. " + self.id.to_s
      end
    end

    def score
      require 'yelp'
      yelp_client = Yelp::Client.new(
        consumer_key: ENV["YELP_CONSUMER_KEY"],
        consumer_secret: ENV["YELP_CONSUMER_SECRET"],
        token: ENV["YELP_TOKEN"],
        token_secret: ENV["YELP_TOKEN_SECRET"]
      )

      specific_score "grocery", 3, false, yelp_client
      specific_score "restaurants", 10, true, yelp_client
      puts "Full score finished."
    end
end
