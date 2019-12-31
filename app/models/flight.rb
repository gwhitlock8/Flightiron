require 'httparty'
require 'date'

class Flight
    has_many :tickets
    has_many :users, through: :tickets

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
    
    def flight_search
        #self.class.get("origin=#{origin}&destination=#{destination}&depart_date=#{departure_date}&return_date=#{return_date}&token=#{API_TOKEN}")
        self.class.get("origin=HOU&destination=LAX&depart_date=2020-01&return_date=2020-02&token=")
    end




end

#https://USERNAME:PASSWORD@opensky-network.org/api/flights/departure?airport=EDDF&begin=1517227200&end=1517230800
puts test_flight.flight_search
