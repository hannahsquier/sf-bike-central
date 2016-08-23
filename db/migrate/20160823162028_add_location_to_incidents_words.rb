class AddLocationToIncidentsWords < ActiveRecord::Migration[5.0]
  def change
  	add_column :incidents, :location, :string
  end
end
