require 'date'

class Person
    attr_accessor :name, :job, :email, :bank_accounts
  
    def initialize(name, job, email)
      @name = name
      @job = job
      @email = email
      @bank_accounts = []
    end
  
    def add_bank_account(account)
      @bank_accounts << account
    end
  
    def remove_bank_account(account)
      @bank_accounts.delete(account)
    end

    def to_string
        return "name: #{@name}, job: #{@job}, email: #{email}, bank_accounts: #{@bank_accounts.length}"
    end
end

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
      if Validations.validate_amount(amount)
        @balance += amount
        #add the transaction
        Transaction.new(amount, "deposit", self)
        puts "You deposited #{amount}. Your new balance is #{@balance}"
      else
        puts "Invalid amount"
      end
    end
  
    def withdraw(amount)
        if Validations.validate_amount(amount)# amount > 0
            if Validations.validate_withdrawal(amount, @balance) #amount <= @balance
                if Validations.validate_withdrawal_daily_limit(amount, @transactions)
                    @balance -= amount
                    #add the transaction
                    Transaction.new(amount, "withdrawal", self)
                    puts "You withdrew #{amount}. Your new balance is #{@balance}"
                else
                    puts "You have exceeded your daily withdrawal limit"
                end
            else
            puts "Insufficient funds"
            end
        else
            puts "Invalid amount"
        end
    end

    def add_transaction(transaction)
        @transactions << transaction
    end

    def to_string
        return "balance: #{@balance}, pin: #{@pin}, person: #{@person.name}, transactions: #{@transactions.length}"
    end
end

class Transaction
    attr_accessor :amount, :type, :date
  
    def initialize(amount, type, bank_account)
      @amount = amount
      @type = type
      @date = Date.today
      bank_account.add_transaction(self)
    end
end

      
