require 'unirest'
require 'pry'

class Flight < ActiveRecord::Base
    has_many :tickets
    has_many :users, through: :tickets

    def self.convert_departure_date(departure_date)
        result = []
        #departure time of flight will fall within the from_local (7 AM) and to_local (7 PM) times for the requested date
        from_local = departure_date + "T07:00"
        to_local = departure_date + "T19:00"
        result << from_local
        result << to_local
    end

    def self.convert_user_city_to_icao_airport_code(city)
        #searches for ICAO code using the city name entered by the user
        Airport.find_by(city: city).icao_code
    end

    def self.find_flights(city,date,user)
        base_url = ("https://aerodatabox.p.rapidapi.com/flights/airports/icao/")
        icao_code = self.convert_user_city_to_icao_airport_code(city)
        depart_date = self.convert_departure_date(date)
        search_url = base_url + icao_code + "/" + depart_date[0] + "/" + depart_date[1]+"?direction=Both"
        response = Unirest.get(search_url,
        headers: {
            "X-RapidAPI-Host" => 'aerodatabox.p.rapidapi.com',
            "X-RapidAPI-Key" => '1e154c357amshfaf5d18e6b67adap1fd93bjsnd7ec462b2288'
        })
        #binding.pry
        response.body["departures"].each do |flight|
                flight_num = flight["number"]
                airline = flight["airline"]["name"]
                departure_location = user.hometown
                departure_date = flight["movement"]["scheduledTimeLocal"].first(10)
                arrival_location = flight["movement"]["airport"]["name"]
                Flight.create(flight_number: flight_num,airline: airline, departure_location: departure_location,departure_date:departure_date,arrival_location:arrival_location)
        end


        user_flights = Flight.where(departure_location: user.hometown,arrival_location:city,departure_date:date)
        #binding.pry
        user_flights
        FlightironApp.display_flights(user_flights)
    end
end
