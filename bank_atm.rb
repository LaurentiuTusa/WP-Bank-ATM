$LOAD_PATH << '.'
require 'validations'
require_relative 'models/initializer'

#Begin of demo data
p1 = Person.new("John", "Developer", "j@yahoo.com")
p2 = Person.new("Tudor", "Climbing instructor", "t@tahoo.com")

persons = []
persons << p1
persons << p2

b1 = BankAccount.new("1234", p1, 150)
b2 = BankAccount.new("5555", p1, 5500)# with 1 widthrawal already
b3 = BankAccount.new("9999", p2, 7000)

b2.withdraw(4000)
#End of demo data

#Auxiliary methods:
def validate_person_name(name, persons)
    person = persons.find { |person| person.name == name }
    raise StandardError.new("No user found with that name") if person.nil?
    person
end

def validate_person_bank_account(bank_accounts, pin)
    selected_bank_acc = bank_accounts.find { |account| account.pin_matches?(pin) }
    raise StandardError.new "Invalid PIN" if selected_bank_acc.nil?
    selected_bank_acc
end

#Options methods:
def deposit_funds(persons)
    puts "Insert your name:"
    input_name = gets.chomp
    puts "Insert PIN:"
    input_pin = gets.chomp

    #verify input_name and input_pin
    current_user = validate_person_name(input_name, persons)
    bank_acc = validate_person_bank_account(current_user.bank_accounts, input_pin)

    puts "How much would you like to deposit, #{input_name}?"
    input_amount = gets.chomp.to_i
    bank_acc.deposit(input_amount)
    puts "You deposited #{input_amount}. Your new balance is #{bank_acc.balance}"
rescue StandardError => e 
    puts e    
end

def withdraw_funds(persons)
    puts "Insert your name:"
    input_name = gets.chomp
    puts "Insert PIN:"
    input_pin = gets.chomp

    #verify input_name and input_pin
    current_user = validate_person_name(input_name, persons)
    bank_acc = validate_person_bank_account(current_user.bank_accounts, input_pin)

    puts "How much would you like to withdraw, #{input_name}?"
    input_amount = gets.chomp.to_i
    bank_acc.withdraw(input_amount)
    puts "You withdrew #{input_amount}. Your new balance is #{bank_acc.balance}"
rescue StandardError => e 
    puts e    
end

def create_account(persons)
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
end

def view_all_accounts(persons)
    persons.each {|person| person.bank_accounts.each {|account| puts account.to_string} }
end

#Start of the flow
loop do
    puts "\nWelcome to the ATM!"
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
        deposit_funds(persons)
    when "2"
        withdraw_funds(persons)
    when "3"
        create_account(persons)
    when "4"
        view_all_accounts(persons)
    else
        puts "Invalid option"
    end
end
