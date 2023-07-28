require_relative '../validations' 

AccountValidations = Validations::AccountValidations

class BankAccount
    attr_accessor :balance, :pin, :person, :transactions
  
    def initialize(pin, person, balance = 0)
      @balance = balance
      @pin = pin
      @person = person
      @transactions = []
      person.add_bank_account(self)
    end
  
    def pin_matches?(input_pin)
      @pin == input_pin
    end

    def deposit(amount)
      AccountValidations.validate_amount(amount)
      @balance += amount
      Transaction.new(amount, "deposit", self)
    end
  
    def withdraw(amount)
      AccountValidations.validate_amount(amount)# amount > 0
      AccountValidations.validate_withdrawal(amount, @balance) #amount <= @balance
      AccountValidations.validate_withdrawal_daily_limit(amount, @transactions) #check daily limit
      @balance -= amount 
      Transaction.new(amount, "withdrawal", self)
    end

    def add_transaction(transaction)
      @transactions << transaction
    end

    def to_string
      "balance: #{@balance}, pin: #{@pin}, person: #{@person.name}, transactions: #{@transactions.length}"
    end
end
