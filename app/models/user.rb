class User < ActiveRecord::Base
    
    def self.create_account(username)
        puts 'User account not found. Creating new account.'
        print "Please choose a password: "
        password = gets.chomp
        print "Please enter your hometown: "
        hometown = gets.chomp
        User.create(username: username, password: password, hometown: hometown)
    end

end