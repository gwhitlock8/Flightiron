require 'active_record'

class Ticket < ActiveRecord::Base

    belongs_to :flight
    belongs_to :user

    def self.print(userid)
      #  p "No tickets have been made yet" if Ticket.where(user_id: userid).length == 0
        puts "|Flight ID|  Departure Date| Location To-From   | User’s Name   |"
        Ticket.where(user_id: userid).each do |ticket|
            self.format(ticket[:user_id], ticket[:flight_id])
        end
         puts '-'*80
    end

    def self.format(user_id, flight_id)
        puts '~'*80
        my_flight = Flight.find_by_id(flight_id)
        my_user = User.find_by_id(user_id)
        puts "|#{flight_id}\t  |    #{my_flight.departure_date} | #{my_flight.arrival_location} - #{my_flight.departure_location}   |\t#{my_user.username}\t   |"
    end

    def self.cancel_ticket(user_id)
        self.print(user_id)
        puts 'Please select the flight id of the ticket you would like to cancel: '
        cancelled_flight = gets.chomp.to_i
       # binding.pry
        cancelled_ticket = Ticket.find_by(flight_id:cancelled_flight)
        cancelled_ticket.destroy
    end

end