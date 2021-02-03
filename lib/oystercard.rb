class Oystercard

    attr_reader :balance, :journey
    LIMIT_CONST = 90
    MIN_BALANCE = 1
    MINIMUM_CHARGE = 1 


    def initialize()
      @balance = 0
      @limit = LIMIT_CONST
      @journey = false
    end

    def top_up(amount)
      fail "Balance cannot exceed #{@limit}" unless (amount + @balance) <= @limit
      @balance += amount
    end

    def deduct(amount)
      @balance -= amount
    end

    def touch_in
      fail 'Not enough money on card' unless @balance >= MIN_BALANCE
      @journey = true
    end

    def touch_out
      deduct(MINIMUM_CHARGE)
      @journey = false
    end
end