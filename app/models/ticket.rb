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
        self.print(user_id)
        prompt = TTY::Prompt.new
        flight_choice = prompt.ask('Please select the flight id of the ticket you would like to cancel: '.red.bold)
        flight_choice.to_i
        if Ticket.find_by(user_id: user_id,flight_id: flight_choice)
            Ticket.find_by(user_id: user_id,flight_id: flight_choice).destroy
        else
            puts "Flight ID is not in list of purchased tickets."
            sleep(1)
            self.check_ticket(user_id)
        end
        #             matching_id = Ticket.where(user_id: user_id).find do |ticket|
        #     ticket.flight_id == flight_choice
        # end
        # binding.pry
        # if matching_id
        #     matching_id
        # else
        #     puts 'Flight ID does not match'
        #     sleep(2)
        #     matching_id = self.check_ticket(user_id)
        # end
        # matching_id
    end

end