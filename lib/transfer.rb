class Transfer
    attr_reader :sender, :receiver, :amount
    attr_accessor :status
    def initialize(sender, receiver, amount)
        @sender = sender
        @receiver = receiver
        @amount = amount
        @status = 'pending'
    end

    def valid?
      (sender.valid? && receiver.valid?) ? true : false
    end

    def execute_transaction
      puts @sender.valid?
      if (@status == 'pending' && @sender.valid? && @receiver.valid? && @sender.balance >= amount)
        @sender.deposit(-amount)
        @receiver.deposit(amount)
        @status = "complete"
      else 
        @status = "rejected"
        "Transaction rejected. Please check your account balance."
      end
    end

    def reverse_transfer
      if (@status == 'complete' && @receiver.valid?)
        @receiver.deposit(-amount)
        @sender.deposit(amount)
        @status = "reversed"
      end 
    end
end
