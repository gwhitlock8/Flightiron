class FlightironApp

    #####This is just a rough version of the app for guidance
    #####If you don't agree with how the methods are called in the #call_method class, make note of it in github or something
    attr_reader :current_user

    def self.start
      self.login
      self.call_method
    end

    def self.login
        puts 'Greetings. Welcome to the flightiron app'
        print 'please enter your username:'
        username = gets.chomp
        User.find_by(username: username) ? @current_user = User.verify_password(username) : @current_user = User.create_account(username)
       # binding.pry
        puts "Hello #{@current_user.username}!"
       #  binding.pry
    end

    def self.menu
       
         puts 'Please select an option:
        1. Look for flights
        2. View Tickets
        3. Update Info
        4. Cancel Flight
        5. Close App'
        self.get_user_choice
    end

    def self.get_user_choice
        gets.chomp.to_i
    end

    def self.format_date
        month = self.get_month
        day = self.get_day
        "2020-#{month}-#{day}"
    end

    def self.get_month
        print "Please enter a month 1-12 : "
        month = gets.chomp
        while month.to_i < 1 || month.to_i > 12 || month == "[a-zA-Z]"
            print "Please enter a month 1-12 : "
            month = gets.chomp
        end

        "%02d" % month
    end

    def self.get_day
        print "Please enter a day 1-31: "
        day = gets.chomp
        while day.to_i < 1 || day.to_i > 31 || day == "[a-zA-Z]"
            print "Please enter a day 1-31 : "
            day = gets.chomp
        end
        "%02d" % day
    end

    def self.display_flights(flights)
        puts "
        |Option |Flight ID| Departure Date | Location To-From  |
        --------------------------------------------------------"
        flights.each_with_index do |flight, index|
         puts "|#{index + 1}.    |   #{flight[:flight_number]}  |  #{flight[:departure_date]} |   #{flight[:departure_location]}  - #{flight[:arrival_location]}|"
        end
        #format the flight info into a pretty style
        #show 5 at a time 
        #add options (show more flights), quit
        self.select_flight(flights)
    end

    def self.select_flight(flights)
        puts 'please select a flight to confirm ticket, q to quit'
        choice = gets.chomp
        case choice
        when 'q'
            puts 'returning to main menu'
        else
            flight = flights[choice.to_i - 1]
           # binding.pry
            new_ticket = Ticket.create(user_id: @current_user.id, flight_id: flight.id)
            @current_user.tickets << new_ticket
            flight.tickets << new_ticket
        end
    end

    def self.call_method
        choice = self.menu
        case choice
        when 1
            print 'please enter destination:'
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
           puts 'closing app....'
           puts 'Thank you for using the Flightiron app. Have a nice day.'
        else 
           puts "\n\nIncorrect input. Please enter 1 - 5 \n\n\n"
           sleep(2)
           self.call_method
        end
    end

end