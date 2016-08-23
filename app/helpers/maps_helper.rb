module MapsHelper

	def terrain?
		
		return true if params["terrain"]
		false
	end

	def bikeshare?
		
		return true if params["bikeshare"]
		false
	end
end
