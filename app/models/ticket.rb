class Ticket < ActiveRecord::Base

    belongs_to :flight
    belongs_to :user

    def self.print(userid)
        puts "|Flight ID|  Departure Date| Location To-From   | User’s Name   |"
        Ticket.where(user_id: userid).each do |ticket|
            self.format(ticket[user_id], ticket[flight_id])
        end
         puts '-'*80
    end

    def self.format(user_id, flight_id)
        puts '~'*80
        my_flight = Flight.find_by_id(flight_id)
        my_user = User.find_by_id(user_id)
        puts "|#{flight_id}| #{my_flight.depart_date}| #{my_flight.arrival_city} - #{my_flight.depart_city}| #{user_id}|"
    end

    def self.cancel_ticket(user_id)
        self.print(user_id)
        print 'Please select the flight id of the ticket you would like to cancel: '
        cancelled_flight = gets.chomp.to_i
        Ticket.find_by(user_id: user_id,flight_id: cancelled_flight) ? Ticket.destroy(flight_id: cancelled_flight) : (puts "invalid flight id")
    end

end