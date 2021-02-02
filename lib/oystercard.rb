class Oystercard

    attr_reader :balance
    attr_reader :journey
    LIMIT_CONST = 90

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
      @journey = true
    end

    def touch_out
      @journey = false
    end
end