module Validations
    def Validations.validate_amount(amount)
        if amount > 0
            return true
        else
            return false
        end
    end

    def Validations.validate_withdrawal(amount, balance)
        if amount > balance
            return false
        else
            return true
        end
    end

    def Validations.validate_withdrawal_daily_limit(amount, transactions)
        daily_total = 0
        transactions.each do |transaction|
            if (transaction.date == Date.today && transaction.type == "withdrawal")
                daily_total += transaction.amount
            end
        end
        if daily_total + amount > 5000
            return false
        else
            return true
        end
    end
end
