require 'journey'
require 'station'
class Oystercard

    attr_reader :balance, :journey

    LIMIT_CONST = 90
    MIN_BALANCE = 1
    
    def initialize()
      @balance = 0
      @limit = LIMIT_CONST
      @journey = Journey.new
    end

    def top_up(amount)
      fail "Balance cannot exceed #{@limit}" unless (amount + @balance) <= @limit
      @balance += amount
    end

    def touch_in(station)
      #@journey.update_fare
      fail 'Not enough money on card' unless @balance >= MIN_BALANCE
      @journey.entry_station = station
    end
    
    def touch_out(exit_station)
      @journey.update_fare
      deduct(@journey.fare)
      @journey.journeys.append({entry_station: @journey.entry_station, exit_station: exit_station})
      @journey.entry_station = nil
    end

    private 
    def deduct(amount)
      @balance -= amount
    end
end