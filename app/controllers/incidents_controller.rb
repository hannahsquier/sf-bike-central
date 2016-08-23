class IncidentsController < ApplicationController
		before_action :require_login


		def new
			@incident = current_user.incidents.build
			@neighborhoods = NEIGHBORHOODS
		end


		def create
			@incident = current_user.incidents.build(incident_params)
			@incident.get_coords_from_location

			if @incident.save
		     flash[:success] = "Thanks for your input!"
	        redirect_to root_path

			else
				errors = @user.errors.full_messages.join(", ")
        flash[:sorry] = "We could not create your incident. #{errors}"
        render :new
			end

		end

		def edit
			@incident = Incident.find(params[:id])
		end
    

   def update
			@incident = Incident.find(params[:id])

			if @incident.update(incident_params)
				redirect_to root_path
			else
				render :edit
			end
		end

		def destroy
			if Incident.find(params[:id]).destroy
				flash[:success] = "You successfully deleted your incident."
				redirect_to root_path
			else
				flash[:error] = "Incident could not be deleted."
				redirect_to root_path
			end
		end
        

		private

		def incident_params
			params.require(:incident).permit(:location, :description, :neighborhood)
		end
end
