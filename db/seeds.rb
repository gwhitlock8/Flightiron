require 'csv'
#require 'activerecord'
require 'pry'

csv = CSV.parse(File.read("./lib/seeds/airport_codes.csv"), :headers => true)

csv.each do |row|
    if row['type'] == 'large_airport' && row['iso_country'] == 'US'
        #binding.pry
        row.to_h
        t = Airport.new
        t.name = row['name']
        t.region = row['iso_region']
        t.city = row['municipality']
        t.icao_code = row['gps_code']
        t.save
    else 
        next
    end
end