class Ticket < ActiveRecord::Base

    belongs_to :flight
    belongs_to :user

    def self.print(userid)
        puts "|Flight ID|  Departure Date| Location To-From   | User’s Name   |"
        Ticket.where(user_id: userid).each do |ticket|
            self.format(ticket)
        end
        20.times {puts '-'}
    end

    def self.format(ticket)
        20.times {puts "~"}
        puts "|#{ticket[:flight_id]}| #{ticket[:date]}"
    end

end