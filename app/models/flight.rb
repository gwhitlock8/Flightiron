require 'httparty'
require 'date'

class Flight
    #has_many :tickets
    #has_many :users, through: :tickets

    def convert_user_date_to_unix_timestamp(year,month,day)
        Date.new(year,month,day).to_time.to_i
    end

    def convert_unix_timestamp_to_datetime(timestamp)
        result = []
        date_time = Time.at(timestamp)
        date = date_time.strftime("%m/%d/%Y")
        time = date_time.strftime("%I:%M%p")
        result << date
        result << time
        result
    end

    def convert_user_city_icao_airport_code(city)
    
    end

    def self.find_flights(destination, date)
        puts "#{destination}, #{date}"
        #call method that gets api
        #calls an app method that returns the flight data
        #EX FlightironApp.display_flights(Get http:// whatever)

    end

end

#https://USERNAME:PASSWORD@opensky-network.org/api/flights/departure?airport=EDDF&begin=1517227200&end=1517230800
