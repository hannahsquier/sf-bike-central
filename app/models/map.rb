NEIGHBORHOODS = ["Castro District", "Chinatown", "Cole Valley", "Financial District", "Fisherman's Wharf", "Haight Ashbury", "Hayes Valley"," Japantown", "Lower Haight", "Marina", "Mission District", "Nob Hill", "Noe Valley", "North Beach", "Pacific Heights", "Panhandle", "Potrero Hill", "Presidio", "Richmond"," Russian Hill", "Sea Cliff","SOMA", "Sunset", "Tenderloin", "Union Square", "Upper Market"]

BS_NEIGHBORHOODS = {"Chinatown" => true, "Financial District" => true, "Fisherman's Wharf"=> true, "Hayes Valley"=> true," Japantown"=> true, "Lower Haight"=> true,  "Nob Hill"=> true, "North Beach"=> true, " Russian Hill"=> true, "SOMA"=> true, "Tenderloin"=> true, "Union Square"=> true}


class Map

	def get_map_urls
		map_urls = {}
#{add_bike_share_markers_to_url if BS_NEIGHBORHOODS[neighborhood]}
		NEIGHBORHOODS.each do |neighborhood|
			map_urls[neighborhood] = "https://maps.googleapis.com/maps/api/staticmap?center=#{urlify(neighborhood)},San+Francisco,CA&zoom=15&size=600x600&scale=2&maptype=roadmap#{add_incident_markers}&key=#{Rails.application.secrets.gmaps_static_api_key}"
			end
			map_urls
	end

	def get_bike_share_response
		response = HTTParty.get("https://data.sfgov.org/api/views/gtyg-jpkj/rows.json?accessType=DOWNLOAD")
		response["meta"]["view"]["columns"].last["cachedContents"]["top"]
	end

	def add_bike_share_markers_to_url
		markers = ""
		get_bike_share_response.each do |station|
			markers << "&markers=color:blue%7Clabel:S%7C#{station["item"]["latitude"][0..8]},#{station["item"]["longitude"][0..8]}"
		end
		markers
	end

	def add_incident_markers
		markers = ""
		
		Incident.all.each do |incident|
			markers << "&markers=color:red%7Clabel:#{incident.id}%7C#{incident.latitude},#{incident.longitude}"
		end
		markers
	end
	private

	def urlify(neighborhood)
		neighborhood.gsub(" ", "+")
	end

end