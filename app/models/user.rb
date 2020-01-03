class User < ActiveRecord::Base

    has_many :tickets
    has_many :flights, through: :tickets

    
    def self.create_account(username)
        puts 'User account not found. Creating new account.'
        print "Please choose a password: "
        password = gets.chomp
        print "Please enter your hometown: "
        hometown = gets.chomp
        User.create(username: username, password: password, hometown: hometown)
    end

    def user_update
        puts 'Please select the attribute that you would like to update:
        1. username
        2. password
        3. hometown
        q. quit'
        choice = gets.chomp
        #binding.pry
        case choice
        when '1'
            print 'Please enter your new username: '
            username = gets.chomp
            self.update(username: username)
        when '2'
            print 'Please enter your new password: '
            password = gets.chomp
            self.update(password: password)
        when '3'
            print 'Please enter your new hometown: '
            hometown = gets.chomp
            self.update(hometown: hometown)
        when 'q'  || 'Q'
            puts 'returning to menu....'
        else
            puts 'Please enter a number between 1 - 3, or q to quit.'
            self.user_update
        end
    end

    def self.verify_password(username)
        print "Please enter your password: "
        password_input = gets.chomp
       # binding.pry
        if User.where(username: username, password: password_input).length != 0
            #binding.pry
            return User.where(username: username, password: password_input).take
        else
           # binding.pry
            puts "Incorrect username - password combination"
            self.verify_password(username)
            #FlightironApp.login
        end
    end

end