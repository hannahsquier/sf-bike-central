class MapsController < ApplicationController
	def show
		@map_urls = Map.new(terrain: params[:terrain], bikeshare: params[:bikeshare]).get_map_urls
		@incidents = Incident.all.order(:id)
	end
end
