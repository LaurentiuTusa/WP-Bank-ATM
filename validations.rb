module Validations
    class AccountValidations
        class << self
            def validate_amount(amount)#amount > 0
                raise StandardError.new "Invalid amount. Amount must be positive" if !(amount.positive?)
            end
    
            def validate_withdrawal(amount, balance)#amount <= balance
                raise StandardError.new "Insufficient funds" if (amount > balance)
            end

            def validate_withdrawal_daily_limit(amount, transactions)#daily_total + amount <= 5000
                daily_total = 0
                transactions.each do |transaction|
                    if (transaction.date == Date.today && transaction.type == "withdrawal")
                        daily_total += transaction.amount
                    end
                end
                raise StandardError.new "You have exceeded your daily withdrawal limit" if ((daily_total + amount) > 5000)
            end
        end
    end
end
