class FlightironApp

    #####This is just a rough version of the app for guidance
    #####If you don't agree with how the methods are called in the #call_method class, make note of it in github or something
    attr_reader :current_user

    def self.start
      self.login
      #self.menu
      self.call_method
    end

    def self.login
        puts 'Greetings. Welcome to the flightiron app'
        print 'please enter your username:'
        username = gets.chomp
        User.find_by(username: username) ? @current_user = User.find_by(username: username) : @current_user = User.create_account(username)
        # binding.pry
    end

    def self.menu
        puts "Welcome back #{@current_user.username}!"
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

    def self.call_method
        choice = self.menu
        case choice
        when 1
           puts "Calling Flight.find flights"
           self.call_method
        when 2
           Ticket.print(@current_user.id)
           self.call_method
        when 3
             puts'calling User.change_username'
           self.call_method
        when 4
            puts'calling Tickets(?).cancel_flight '
           self.call_method
        when 5
           puts 'closing app'
        else 
           puts "wrong input try again dummy\n\n\n"
           self.call_method
        end
    end

end