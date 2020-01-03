class User < ActiveRecord::Base

    has_many :tickets
    has_many :flights, through: :tickets

    
    def self.create_account(username)
        prompt = TTY::Prompt.new
        puts 'User account not found. Creating new account.'.cyan.bold
        password = prompt.mask("Please choose a password: ")
        hometown =  prompt.ask("Please enter your hometown: ")
        User.create(username: username, password: password, hometown: hometown)
    end

    def user_update
        prompt = TTY::Prompt.new
        choices = ['Update Username','Update Password','Update Hometown','Return to Main Menu']
        choice = prompt.select("Please select an option below:",choices)
        case choice
        when 'Update Username'
            username = prompt.ask("Please enter your new username: ")
            self.update(username: username)
        when 'Update Password'
            password = prompt.mask('Please enter your new password: ')
            self.update(password: password)
        when 'Update Hometown'
            hometown = prompt.ask('Please enter your new hometown: ')
            self.update(hometown: hometown)
        when 'Return to Main Menu'
            FlightironApp.menu
        end
    end

    def self.verify_password(username)
        prompt = TTY::Prompt.new
        password_input = prompt.mask("Please enter your password: ")

        if User.where(username: username, password: password_input).length != 0
            return User.where(username: username, password: password_input).take
        else
            puts "Incorrect username - password combination"
            self.verify_password(username)
        end
    end

end