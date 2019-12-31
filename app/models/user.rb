class User < ActiveRecord::Base
    
    def self.create_account(username)
        print "Please enter your password: "
        password = gets.chomp
        print "Please enter your hometown: "
        hometown = gets.chomp
        User.new(username: username, password: password, hometown: hometown)
    end

end