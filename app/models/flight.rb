require 'httparty'
require 'awesome_print'

class Flight
    include HTTParty
    base_uri "http://api.travelpayouts.com/v1/prices/cheap?"
    
    def flight_search
        #self.class.get("origin=#{origin}&destination=#{destination}&depart_date=#{departure_date}&return_date=#{return_date}&token=#{API_TOKEN}")
        self.class.get("origin=HOU&destination=LAX&depart_date=2020-01&return_date=2020-02&token=")
    end
end

test_flight = Flight.new

puts test_flight.flight_search
