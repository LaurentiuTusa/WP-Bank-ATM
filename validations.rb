module Validations
    class AccountValidations
        class << self
            def validate_amount(amount)
                amount > 0
            end
    
            def validate_withdrawal(amount, balance)
                amount <= balance
            end

            def validate_withdrawal_daily_limit(amount, transactions)
                daily_total = 0
                transactions.each do |transaction|
                    if (transaction.date == Date.today && transaction.type == "withdrawal")
                        daily_total += transaction.amount
                    end
                end
                (daily_total + amount) <= 5000
            end
        end
    end
end
