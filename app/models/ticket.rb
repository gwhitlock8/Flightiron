class Ticket < ActiveRecord::Base

    belongs_to :flight
    belongs_to :user

    def self.print(userid)

        table_data = []

        Ticket.where(user_id: userid).each do |ticket|
            table_data << {"Flight ID" => ticket.flight_id,"Departure Date" => ticket.flight.departure_date,"Departure Location" => ticket.flight.departure_location,"Destination" => ticket.flight.arrival_location, "Departure Time" => ticket.flight.departure_time}
        end
        Formatador.display_table(table_data) unless table_data.empty?
    end

    def self.cancel_ticket(user_id)
        prompt = TTY::Prompt.new
        self.print(user_id)
        cancelled_flight = prompt.ask("Enter the flight id of the ticket you would like to cancel: ".red.bold)
        cancelled_flight.to_i
        cancelled_ticket = Ticket.find_by(flight_id:cancelled_flight)
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