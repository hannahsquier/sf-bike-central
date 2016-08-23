class Incident < ApplicationRecord
  belongs_to :user

  def get_coords_from_location
  	url = "https://maps.googleapis.com/maps/api/geocode/json?address=#{urlify(location)}+San+Francisco,+CA&key=#{Rails.application.secrets.gmaps_geocoding_api_key}"
  	response = HTTParty.get(url, verify: false)["results"].first["geometry"]["location"]

  		update(latitude: response["lat"])
			update(longitude: response["lng"])
  end

  def urlify(location)
  	location.gsub(" ", "+")
  end
end
