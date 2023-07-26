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
    attr_accessor :balance, :pin, :person
  
    def initialize(pin, person, balance = 0)
      @balance = balance
      @pin = pin
      @person = person
      person.add_bank_account(self)
    end
  
    def pin_matches?(input_pin)
        @pin == input_pin
      end

    def deposit(amount)
      if Validations.validate_amount(amount)
        @balance += amount
        puts "You deposited #{amount}. Your new balance is #{@balance}"
      else
        puts "Invalid amount"
      end
    end
  
    def withdraw(amount)
      if Validations.validate_amount(amount)
        if Validations.validate_withdrawal(amount, @balance)
          @balance -= amount
          puts "You withdrew #{amount}. Your new balance is #{@balance}"
        else
          puts "Insufficient funds"
        end
      else
        puts "Invalid amount"
      end
    end

    def to_string
        return "balance: #{@balance}, pin: #{@pin}, person: #{@person.name}"
    end
end
