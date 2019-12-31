class Ticket < ActiveRecord::Base

    belongs_to :flight
    belongs_to :user

    def self.print(userid)
        puts "|Flight ID|  Departure Date| Location To-From   | User’s Name   |"
        Ticket.where(user_id: userid).each do |ticket|
            self.format(ticket[user_id], ticket[flight_id])
        end
        20.times {puts '-'}
    end

    def self.format(user_id, flight_id)
        20.times {puts "~"}
        my_flight = Flight.find_by_id(flight_id)
        my_user = User.find_by_id(user_id)
        puts "|#{flight_id}| #{my_flight.depart_date}| #{my_flight.arrival_city} - #{my_flight.depart_city}| #{user_id}|"
    end

end