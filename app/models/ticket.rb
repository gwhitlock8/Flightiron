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
        flight_id = self.check_ticket(user_id)
    end

    def self.check_ticket(user_id)
        prompt = TTY::Prompt.new
        ticket_choices = []
        ticket_hash = {}
        Ticket.where(user_id: user_id).each do |ticket|
            ticket_hash = {"Flight ID: #{ticket.flight_id} | Destination: #{ticket.flight.arrival_location} | Date/Time: #{ticket.flight.departure_date}/#{ticket.flight.departure_time} | Airline: #{ticket.flight.airline}" => ticket.id}
            ticket_choices << ticket_hash
        end
        cancel_ticket_id = prompt.multi_select("Select flights to cancel", ticket_choices)
        cancel_ticket_id.each do |ticket|
            ticket_to_destroy = Ticket.find_by_id(ticket)
            ticket_to_destroy.destroy
        end

    end

end