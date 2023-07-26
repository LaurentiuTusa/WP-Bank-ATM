$LOAD_PATH << '.'
require 'validations'

class BankUser

    @@users_count = 0
    attr_accessor :name, :job, :email, :pin, :balance
    def initialize(name, job, email, pin, balance = 0)
        @name = name
        @job = job
        @email = email
        @pin = pin
        @@users_count += 1
        @balance = balance
    end

    def self.get_users_count
        return @@users_count
    end

    def addBalance(amount)
        @balance += amount
    end

    def withdrawBalance(amount)
        @balance -= amount
    end

    def to_string
        return "name: #{@name}, job: #{@job}, email: #{@email}, PIN: #{@pin}, balance: #{@balance}"
    end
end

#Demo data
users = {}
user1 = BankUser.new("John", "Developer", "jonny@yahoo.com", "1234", 150)
user2 = BankUser.new("Tudor", "Climbing instructor", "tudorskai@yahoo.com", "9999", 7000)
users[user1.name] = user1
users[user2.name] = user2

loop do
    #Start of the flow
    puts "Welcome to the ATM!"
    puts "Select an option: "
    #Options
    puts "1. Deposit funds"
    puts "2. Withdraw funds"
    puts "3. Create account"
    puts "4. View all accounts"
    puts "5. Quit"

    option = gets.chomp.downcase
    break if option == "5"
    puts "You selected #{option}"

    case option
        when "1"
            puts "Insert your name:"
            input_name = gets.chomp
            puts "Insert PIN:"
            input_pin = gets.chomp

            #verify pin
            current_user = users[input_name]
            if input_pin == current_user.pin
                puts "How much would you like to deposit, #{input_name}?"
                input_amount = gets.chomp.to_i
                unless Validations.validate_amout(input_amount)
                    puts "Invalid amount"
                else
                    current_user.addBalance(input_amount)
                    puts "$#{input_amount} has been added to your account"
                    puts "Your new balance is $#{current_user.balance}"
                end
            else
                puts "Invalid PIN"
            end

        when "2"
            puts "Insert your name:"
            input_name = gets.chomp
            puts "Insert PIN:"
            input_pin = gets.chomp

            #verify pin
            current_user = users[input_name]
            if input_pin == current_user.pin
                puts "How much would you like to withdraw, #{input_name}?"
                input_amount = gets.chomp.to_i
                unless Validations.validate_amout(input_amount)
                    puts "Invalid amount"
                else
                    #verify balance for sufficient funds
                    if input_amount > current_user.balance
                        puts "Insufficient funds"
                    
                    #verify daily withdrawal limit    
                    elsif #error case
                        puts "You have reached your daily withdrawal limit"
                    else #valid case
                        current_user.withdrawBalance(input_amount)
                        puts "$#{input_amount} has been withdrawn from your account"
                        puts "Your new balance is $#{current_user.balance}"
                    end
                end
            else
                puts "Invalid PIN"
            end

        when "3"
            puts "What is your name?"
            input_name = gets.chomp
            puts "What is your job?"
            input_job = gets.chomp
            puts "What is your email?"
            input_email = gets.chomp
            puts "Insert a PIN code:"
            input_pin = gets.chomp
            new_user = BankUser.new(input_name, input_job, input_email, input_pin)
            users[new_user.name] = new_user
        
        when "4"
            users.each {|key, value| puts value.to_string}

        else
            puts "Invalid option"
    end
end

#fa 2 clase, una de user si una de bank accaount