class ChangeIncidentsUserIdId < ActiveRecord::Migration[5.0]
  def change
  	change_column :incidents, :user_id_id, :user_id
  end
end
