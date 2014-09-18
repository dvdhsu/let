namespace :cl_properties do
  desc "update properties from 3taps API"

  task update: :environment do
    anchor = Anchor.last.anchor
    puts "Pre-update anchor -- #{anchor}"

    params = {
      auth_token: ENV["3TAPS_KEY"],
      anchor:     anchor,
      category:   "RSUB",
      status:     "for_rent",
      state:      "available",
      retvals:    "external_id,external_url,heading,body,timestamp,price,expires,annotations,location,images,deleted",
      "location.metro" => "USA-SFO"
    }.to_param

    url = URI.parse("http://polling.3taps.com/poll?#{params}")
    response = Net::HTTP.get(url)

    parsed = JSON.parse(response)

    raise "3taps API troubles during whenever job" unless parsed["success"]
    
    for post in parsed["postings"]
      prop = ClProperty.where(external_id: post["external_id"])

      # if the property is in db...
      if prop.length > 0
        # delete by default
        if post["deleted"]
          prop[0].destroy
          puts "Deleting -- " + post["external_url"]
          # and move to the next one if it's deleted
          next
        else 
          prop[0].destroy
          puts "Updating -- " + post["external_url"]
          # else continue to create it again
        end     
      end

      # if it doesn't have a price, ignore it
      if !post["price"]
        puts "Skipping -- this property has no price."
        next
      end

      # if it's a `wanted' ad, ignore it
      if post["annotations"]["source_subcat"] == "hsw|sbw"
        puts "Skipping -- this property is wanted."
        next
      end

      prop = ClProperty.create!(
        external_id:        post["external_id"],
        external_url:       post["external_url"],
        heading:            post["heading"],
        body:               post["body"],
        rent:               post["price"],
        external_timestamp: post["timestamp"].to_i,
        expires:            post["expires"],
        deleted:            post["deleted"]
      )

      if post["location"].length > 0
        prop.create_cl_location!(
          lat:                post["location"]["lat"],
          long:               post["location"]["long"],
          country:            post["location"]["country"],
          state:              post["location"]["state"] ? post["location"]["state"][-2..-1] : nil,
          metro:              post["location"]["metro"] ? post["location"]["metro"][-3..-1] : nil,
          county:             post["location"]["county"] ? post["location"]["county"][-3..-1] : nil,
          region:             post["location"]["region"] ? post["location"]["region"][-3..-1] : nil,
          city:               post["location"]["city"] ? post["location"]["city"][-3..-1] : nil,
          locality:           post["location"]["locality"] ? post["location"]["locality"][-3..-1] : nil,
          formatted_address:  post["location"]["formatted_address"],
          geolocation_status: post["location"]["geolocation_status"],
          zipcode:            post["location"]["zipcode"] ? post["location"]["zipcode"][-5..-1] : nil,
          accuracy:           post["location"]["accuracy"]
        )
      end

      if post["images"].length > 0
        for image in post["images"]
          prop.cl_images.create!(
            href: image["full"]
          )
        end
      end

      if post["annotations"].length > 0
        prop.create_cl_annotation!(
          num_bed:  post["annotations"]["bedrooms"].to_i,
          num_bath: post["annotations"]["bathrooms"].to_i,
          size:     post["annotations"]["sqft"].to_i,
          avail:    post["annotations"]["available"] ? Date.parse(post["annotations"]["available"]) : nil
        )
      end
    end

    Anchor.create!(anchor: parsed["anchor"], num_polled: parsed["postings"].size)
    puts "Post-update anchor: #{Anchor.last.anchor}"

  end
end
