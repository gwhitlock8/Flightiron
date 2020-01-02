class CreateFlights < ActiveRecord::Migration[5.2]
  def change
    create_table :flights do |t|
      t.string :flight_number
      t.string :departure_location
      t.string :departure_date
      t.string :arrival_location
      t.string :airline
    end
  end
end
