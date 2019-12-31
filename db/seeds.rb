require 'csv'
require 'activerecord'

csv_text = File.read(Rails.root.join('lib','seeds','airport_codes.csv'))
csv = CSV.parse(csv_text, :headers => true, :encoding => 'ISO-8859-1')

csv.each do |row|
    if row['type'] == 'large_airport' && row['iso_country'] == 'US'
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