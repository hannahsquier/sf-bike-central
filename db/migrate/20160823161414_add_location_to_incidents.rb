class AddLocationToIncidents < ActiveRecord::Migration[5.0]
  def change
  	add_column :incidents, :latitude, :decimal
  	add_column :incidents, :longitude, :decimal
  end
end
