require 'active_record'

class Ticket < ActiveRecord::Base

    belongs_to :flight
    belongs_to :user

    def self.print(userid)
      #  p "No tickets have been made yet" if Ticket.where(user_id: userid).length == 0
     # binding.pry
         if Ticket.where(user_id: userid).empty?
         puts "No tickets available :(\n"
         sleep(3)
        else
             puts "|Flight ID|  Departure Date| Location To-From   | User’s Name   |"
             Ticket.where(user_id: userid).each do |ticket|
            self.format(ticket[:user_id], ticket[:flight_id])
            end
         puts '-'*60   
        end

    end

    def self.format(user_id, flight_id)
        puts '~'*80
        my_flight = Flight.find_by_id(flight_id)
        my_user = User.find_by_id(user_id)
        puts "|#{flight_id}\t  |    #{my_flight.departure_date} | #{my_flight.arrival_location} - #{my_flight.departure_location}   |\t#{my_user.username}\t   |"
    end

    def self.cancel_ticket(user_id)
        cancelled_flight = self.check_ticket(user_id)
       # binding.pry
        cancelled_ticket = Ticket.find_by(flight_id:cancelled_flight.flight_id)
       # binding.pry
        cancelled_ticket.destroy
    end

    def self.check_ticket(user_id)
        self.print(user_id)
        puts 'Please select the flight id of the ticket you would like to cancel: '
        flight_choice = gets.chomp.to_i
        matching_id = Ticket.where(user_id: user_id).find do |ticket|
           # binding.pry
            ticket.flight_id == flight_choice
        end
        if matching_id
            matching_id
         else
            puts 'Flight id does not match'
            sleep(2)
            matching_id = self.check_ticket(user_id)
         end
         matching_id
    end

end