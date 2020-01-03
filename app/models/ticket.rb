class Ticket < ActiveRecord::Base

    belongs_to :flight
    belongs_to :user

    def self.print(userid)

        table_data = []

        Ticket.where(user_id: userid).each do |ticket|
            table_data << {"Flight ID" => ticket.flight_id,"Departure Date" => ticket.flight.departure_date,"Departure Location" => ticket.flight.departure_location,"Destination" => ticket.flight.arrival_location, "Departure Time" => ticket.flight.departure_time}
        end
        Formatador.display_table(table_data)
    end

    def self.cancel_ticket(user_id)
        self.print(user_id)
        print "Enter the flight id of the ticket you would like to cancel: ".red
        cancelled_flight = gets.chomp.to_i
        cancelled_ticket = Ticket.find_by(flight_id:cancelled_flight)
        cancelled_ticket.destroy
    end

end