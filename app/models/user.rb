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
        3. hometown'
        choice = gets.chomp

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
        else
            puts 'Please enter a number between 1 - 3.'
            self.user_update
        end
    end

end