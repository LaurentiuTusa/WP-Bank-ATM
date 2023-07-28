require 'date'

class Transaction
    attr_accessor :amount, :type, :date
    
    def initialize(amount, type, bank_account)
      @amount = amount
      @type = type
      @date = Date.today
      bank_account.add_transaction(self)
    end
  end