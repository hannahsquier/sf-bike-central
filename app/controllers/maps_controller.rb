class MapsController < ApplicationController
	def show
		@map_urls = Map.new.get_map_urls
		@incidents = Incident.all
	end
end
