class CreateFlights < ActiveRecord::Migration[5.2]
  def change
    create_table :flights do |t|
      t.integer :flight_number
      t.string :departure_location
      t.datetime :departure_date
      t.datetime :departure_time
      t.string :arrival_location
    end
  end
end
