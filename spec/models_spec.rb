require_relative "../validations"
require_relative "../models/initializer"

#rspec file for testing the Person class
RSpec.describe Person do
    describe ".add_bank_account" do
        it "Adds a bank account to the person p1 upon the creation of the account" do
            p1 = Person.new("Alex", "Doctor", "alex@yahoo.com")
            expect(p1.bank_accounts.length).to eq(0)
            b = BankAccount.new("1234", p1, 7000)
            expect(p1.bank_accounts.length).to eq(1)
        end
    end
end

#rspec file for testing the BankAccount class
RSpec.describe BankAccount do
    describe ".deposit" do
        it "Adds the amount to the balance if the amount is valid" do
            p1 = Person.new("Alex", "Doctor", "alex@yahoo.com")
            b = BankAccount.new("1234", p1, 7000)
            b.deposit(100)
            expect(b.balance).to eq(7100)
        end

        it "Does not add the amount to the balance if the amount is invalid" do
            p1 = Person.new("Alex", "Doctor", "alex@yahoo.com")
            b = BankAccount.new("1234", p1, 7000)
            expect { b.deposit(-100) }.to raise_error(StandardError, "Invalid amount. Amount must be positive")
        end

        it "Adds a transaction to the transactions array" do
            p1 = Person.new("Alex", "Doctor", "alex@yahoo.com")
            b = BankAccount.new("1234", p1, 7000)
            expect(b.transactions.length).to eq(0)
            b.deposit(100)
            expect(b.transactions.length).to eq(1)
        end

        it "Withdraws the amount from the balance if the amount is valid" do
            p1 = Person.new("Alex", "Doctor", "alex@yahoo.com")
            b = BankAccount.new("1234", p1, 7000)
            b.withdraw(100)
            expect(b.balance).to eq(6900)
        end

        it "Does not withdraw the amount from the balance if the amount is invalid" do
            p1 = Person.new("Alex", "Doctor", "alex@yahoo.com")
            b = BankAccount.new("1234", p1, 7000)
            expect { b.withdraw(-100) }.to raise_error(StandardError, "Invalid amount. Amount must be positive")
        end

        it "Does not withdraw the amount from the balance if the amount is greater than the balance" do
            p1 = Person.new("Alex", "Doctor", "alex@yahoo.com")
            b = BankAccount.new("1234", p1, 7000)
            expect { b.withdraw(7100) }.to raise_error(StandardError, "Insufficient funds")
            
        end

        it "Does not withdraw the amount from the balance if the amount is greater than the daily limit" do
            p1 = Person.new("Alex", "Doctor", "alex@yahoo.com")
            b = BankAccount.new("1234", p1, 7000)
            b.withdraw(5000)
            expect(b.balance).to eq(2000)
            expect { b.withdraw(1000) }.to raise_error(StandardError, "You have exceeded your daily withdrawal limit")
        end
    end
end
