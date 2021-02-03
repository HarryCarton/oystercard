class Oystercard

    attr_reader :balance, :entry_station
    LIMIT_CONST = 90
    MIN_BALANCE = 1
    MINIMUM_CHARGE = 1 


    def initialize()
      @balance = 0
      @limit = LIMIT_CONST
      @entry_station = entry_station
    end

    def in_journey?
      !!@entry_station
    end

    def top_up(amount)
      fail "Balance cannot exceed #{@limit}" unless (amount + @balance) <= @limit
      @balance += amount
    end

    def deduct(amount)
      @balance -= amount
    end

    def touch_in(station)
      fail 'Not enough money on card' unless @balance >= MIN_BALANCE
      @entry_station = station
    end

    def touch_out
      deduct(MINIMUM_CHARGE)
      @entry_station = nil
    end
end