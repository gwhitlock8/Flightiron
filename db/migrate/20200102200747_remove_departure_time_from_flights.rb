class RemoveDepartureTimeFromFlights < ActiveRecord::Migration[5.2]
  def change
    remove_column :flights, :departure_time, :datetime
  end
end
