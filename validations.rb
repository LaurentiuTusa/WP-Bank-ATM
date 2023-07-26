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
end


