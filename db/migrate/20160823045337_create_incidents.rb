class CreateIncidents < ActiveRecord::Migration[5.0]
  def change
    create_table :incidents do |t|
      t.string :neighborhood
      t.references :user, foreign_key: true
      t.text :description

      t.timestamps
    end
  end
end
