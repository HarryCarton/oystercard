class Oystercard

    attr_reader :balance, :entry_station, :journeys
    LIMIT_CONST = 90
    MIN_BALANCE = 1
    MINIMUM_CHARGE = 1 


    def initialize()
      @balance = 0
      @limit = LIMIT_CONST
      @entry_station = entry_station
      @journeys = []
    end

    def in_journey?
      !!@entry_station
    end

    def top_up(amount)
      fail "Balance cannot exceed #{@limit}" unless (amount + @balance) <= @limit
      @balance += amount
    end

    def touch_in(station)
      fail 'Not enough money on card' unless @balance >= MIN_BALANCE
      @entry_station = station
    end
    
    def touch_out(exit_station)
      deduct(MINIMUM_CHARGE)
      @journeys.append({entry_station: entry_station, exit_station: exit_station})
      @entry_station = nil
    end

    private 
    def deduct(amount)
      @balance -= amount
    end
end