module Validations
    def Validations.validate_amout(amount)
        if amount > 0
            return true
        else
            return false
        end
    end
end


