require_relative "../validations"
require_relative "../models/initializer"

#rspec file for testing the validations.rb file
RSpec.describe Validations do
    describe "validate_amount" do
        context "Compares the amount to 0" do
            it "raises an error message if amount is less than or equal to 0" do
            expect { AccountValidations.validate_amount(-10) }.to raise_error(StandardError, "Invalid amount. Amount must be positive")
            expect { AccountValidations.validate_amount(0) }.to raise_error(StandardError, "Invalid amount. Amount must be positive")
            end
        
            it "does not raise an error if amount is greater than 0" do
            expect { AccountValidations.validate_amount(10) }.not_to raise_error
            end
        end
    end

    describe ".validate_withdrawal" do
        context "Compares the input amount with the avaliable balance" do
            it "raises an error message if amount is greater than the balance" do
                expect { AccountValidations.validate_withdrawal(100, 90) }.to raise_error(StandardError, "Insufficient funds")
                expect { AccountValidations.validate_withdrawal(150, 0) }.to raise_error(StandardError, "Insufficient funds")
            end

            it "does not raise an error if amount is smaller or equal than the avaliable balance" do
                expect { AccountValidations.validate_withdrawal(10, 10) }.not_to raise_error
                expect { AccountValidations.validate_withdrawal(1, 2) }.not_to raise_error
            end
        end
    end

    describe ".validate_withdrawal_daily_limit" do
        context "Compares the input amount to be withdrawn with the daily limit" do
            it "does not raise an error if amount is less than or equal to 5000 for the current day" do
                p_test = Person.new("Alex", "Doctor", "alex@yahoo.com")
                b_test = BankAccount.new("1234", p_test, 7000)
                transactions = b_test.transactions

                expect { AccountValidations.validate_withdrawal_daily_limit(50, transactions) }.not_to raise_error
                Transaction.new(50, "withdrawal", b_test)
                expect { AccountValidations.validate_withdrawal_daily_limit(100, transactions) }.not_to raise_error
            end

            it "raises an error message if amount is greater than 5000 for the current day" do
                p_test = Person.new("Alex", "Doctor", "alex@yahoo.com")
                b_test = BankAccount.new("1234", p_test, 7000)
                transactions = b_test.transactions

                Transaction.new(4000, "withdrawal", b_test)
                expect { AccountValidations.validate_withdrawal_daily_limit(1001, transactions) }.to raise_error(StandardError, "You have exceeded your daily withdrawal limit")#5000 is allowed for the day, so we expect false for 5001
            end
        end
    end
end
