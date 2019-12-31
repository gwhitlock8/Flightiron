class CreateAirports < ActiveRecord::Migration[5.2]
  def change
    create_table :airports do |t|
      t.string :name
      t.string :region
      t.string :city
      t.string :icao_code
    end
  end
end
