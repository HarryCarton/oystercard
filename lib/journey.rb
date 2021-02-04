class Journey 

  attr_reader :journeys, :fare
  attr_accessor :entry_station

  MINIMUM_CHARGE = 1 
  PENALTY_FARE = 6

  def initialize
    @entry_station = entry_station
    @journeys = []
    @fare = PENALTY_FARE
  end

  def in_journey?
    !!@entry_station
  end

  def update_fare
    if in_journey?
      @fare = PENALTY_FARE
    else
      @fare = MINIMUM_CHARGE
    end
  end
end