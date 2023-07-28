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
      "name: #{@name}, job: #{@job}, email: #{email}, bank_accounts: #{@bank_accounts.length}"
    end
end
