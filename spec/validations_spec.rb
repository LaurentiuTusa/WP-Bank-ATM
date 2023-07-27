require_relative "../validations"
require_relative "../models"

#rspec file for testing the validations.rb file
RSpec.describe Validations do

    describe ".validate_amount" do
        context "Compares the amount to 0" do
            it "returns false if amount is less than or equal to 0" do
                expect(Validations.validate_amount(-10)).to eq(false)
                expect(Validations.validate_amount(0)).to eq(false)
            end

            it "returns true if amount is greater than 0" do
                expect(Validations.validate_amount(15)).to eq(true)
            end
        end
    end

    describe ".validate_withdrawal" do
        context "Compares the input amount with the avaliable balance" do
            it "returns false if amount is greater than the balance" do
                expect(Validations.validate_withdrawal(100, 90)).to eq(false)
                expect(Validations.validate_withdrawal(150, 0)).to eq(false)
            end

            it "returns true if amount is smaller or equal than the avaliable balance" do
                expect(Validations.validate_withdrawal(10, 10)).to eq(true)
                expect(Validations.validate_withdrawal(1, 2)).to eq(true)
            end
        end
    end

    describe ".validate_withdrawal_daily_limit" do
        context "Compares the input amount to be withdrawn with the daily limit" do
            it "returns true if amount is less than or equal to 5000 for the current day" do
                p_test = Person.new("Alex", "Doctor", "alex@yahoo.com")
                b_test = BankAccount.new("1234", p_test, 7000)
                transactions = b_test.transactions

                expect(Validations.validate_withdrawal_daily_limit(50, transactions)).to eq(true)
                Transaction.new(50, "withdrawal", b_test)
                expect(Validations.validate_withdrawal_daily_limit(100, transactions)).to eq(true)
            end

            it "returns false if amount is greater than 5000 for the current day" do
                p_test = Person.new("Alex", "Doctor", "alex@yahoo.com")
                b_test = BankAccount.new("1234", p_test, 7000)
                transactions = b_test.transactions

                Transaction.new(4000, "withdrawal", b_test)
                expect(Validations.validate_withdrawal_daily_limit(1001, transactions)).to eq(false)#5000 is allowed for the day, so we expect false for 5001
            end
        end
    end
end

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
            b.deposit(-100)
            expect(b.balance).to eq(7000)
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
            b.withdraw(-100)
            expect(b.balance).to eq(7000)
        end

        it "Does not withdraw the amount from the balance if the amount is greater than the balance" do
            p1 = Person.new("Alex", "Doctor", "alex@yahoo.com")
            b = BankAccount.new("1234", p1, 7000)
            b.withdraw(7100)
            expect(b.balance).to eq(7000)
        end

        it "Does not withdraw the amount from the balance if the amount is greater than the daily limit" do
            p1 = Person.new("Alex", "Doctor", "alex@yahoo.com")
            b = BankAccount.new("1234", p1, 7000)
            b.withdraw(5000)
            expect(b.balance).to eq(2000)
            b.withdraw(1000)
            expect(b.balance).to eq(2000)
        end
    end
end
