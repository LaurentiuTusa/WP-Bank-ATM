$LOAD_PATH << '.'
require 'validations'
require 'models'

#Demo data
p1 = Person.new("John", "Developer", "j@yahoo.com")
p2 = Person.new("Tudor", "Climbing instructor", "t@tahoo.com")

persons = []
persons << p1
persons << p2

b1 = BankAccount.new("1234", p1, 150)
b2 = BankAccount.new("5555", p1, 5500)
b3 = BankAccount.new("9999", p2, 7000)

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
        when "1" #deposit
            puts "Insert your name:"
            input_name = gets.chomp
            puts "Insert PIN:"
            input_pin = gets.chomp

            #verify pin
            current_user = persons.find {|person| person.name == input_name}
            if current_user == nil 
                puts "No user found with that name"

            #find the bank account
            elsif bank_acc = current_user.bank_accounts.find {|account| account.pin_matches?(input_pin) }
                puts "How much would you like to deposit, #{input_name}?"
                input_amount = gets.chomp.to_i
                bank_acc.deposit(input_amount)
            else
                puts "Invalid PIN"
            end

        when "2" #withdraw funds
            puts "Insert your name:"
            input_name = gets.chomp
            puts "Insert PIN:"
            input_pin = gets.chomp

            #verify pin
            current_user = persons.find {|person| person.name == input_name}
            if current_user == nil 
                puts "No user found with that name"

            #find the bank account
            elsif bank_acc = current_user.bank_accounts.find {|account| account.pin_matches?(input_pin) }
                puts "How much would you like to widthraw, #{input_name}?"
                input_amount = gets.chomp.to_i
                bank_acc.withdraw(input_amount)
            else
                puts "Invalid PIN"
            end

        when "3" #create account
            puts "What is your name?"
            input_name = gets.chomp
            puts "What is your job?"
            input_job = gets.chomp
            puts "What is your email?"
            input_email = gets.chomp
            puts "Insert a PIN code:"
            input_pin = gets.chomp

            new_person = Person.new(input_name, input_job, input_email)
            new_bank_account = BankAccount.new(input_pin, new_person)
            persons << new_person
        
        when "4" #view all accounts
            persons.each {|person| person.bank_accounts.each {|account| puts account.to_string} }

        else
            puts "Invalid option"
    end
end
