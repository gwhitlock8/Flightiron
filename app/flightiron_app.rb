require 'formatador'
class FlightironApp

    #####This is just a rough version of the app for guidance
    #####If you don't agree with how the methods are called in the #call_method class, make note of it in github or something
    attr_reader :current_user

    def self.start
      self.login
      self.call_method
    end

    def self.login
        puts "Greetings. Welcome to the flightiron app!".yellow
        print "Please enter your username: ".green.bold
        username = gets.chomp
        User.find_by(username: username) ? @current_user = User.find_by(username: username) : @current_user = User.create_account(username)
        print "Hello".light_blue
        print " #{@current_user.username}".blue.bold
        puts "!!!!!!".light_blue
        # binding.pry
    end

    def self.menu
       
        puts 'Please select an option:
        1. Look for flights
        2. View Tickets - no choose -- broken
        3. Update Info
        4. Cancel Flight
        5. Close App'
        self.get_user_choice
    end

    def self.get_user_choice
        gets.chomp.to_i
    end

    def self.format_date
        print 'please enter month of travel:'
        month = gets.chomp
        print 'please enter day of travel:'
        day = gets.chomp
        "2020-#{month}-#{day}"
    end

    def self.display_flights(flights)
        table_data = []
        flights.each_with_index do |flight, index|
            table_data << {"Flight ID" => index + 1, "Date" => flight[:departure_date], "Departure Location" => flight[:departure_location], "Arrival Location" => flight[:arrival_location], "Airline" => flight[:airline],"Departure Time" => flight[:departure_time]}
        end

        Formatador.display_table(table_data)
        #format the flight info into a pretty style
        #show 5 at a time 
        #add options (show more flights), quit
        self.select_flight(flights)
    end

    def self.select_flight(flights)
        print "Please select a Flight ID to confirm ticket, 'Q' to quit: ".cyan.bold
        choice = gets.chomp
        case choice
        when 'q' || 'Q'
            puts "Returning to main menu...".green
            self.call_method   
        else
            flight = flights[choice.to_i - 1]
            new_ticket = Ticket.create(user_id: @current_user.id, flight_id: flight.id)
            @current_user.tickets << new_ticket
            flight.tickets << new_ticket
        end
    end

    def self.call_method
        choice = self.menu
        case choice
        when 1
            print "Please enter destination: ".green.bold
            destination = gets.chomp
            date = format_date
            Flight.find_flights(destination,date,@current_user)
            self.call_method
        when 2
           Ticket.print(@current_user.id)
           self.call_method
        when 3
            @current_user.user_update
            self.call_method
        when 4
            Ticket.cancel_ticket(@current_user.id)
            self.call_method
        when 5
           puts "Closing app....".red.bold
           puts "Thank you for using the Flightiron app. Have a nice day!".green.bold
        else 
           puts "Invalid Selection. Try again!".red.bold
           self.call_method
        end
    end

end