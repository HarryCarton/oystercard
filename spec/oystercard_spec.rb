require 'oystercard'

describe Oystercard do
  it 'returns balance initial of 0 on .balance call' do
    expect(subject.balance).to eq(0)
  end

  describe '#top_up' do
    it 'adds the correct amount of money to a card' do
      subject.top_up(10)
      expect(subject.balance).to eq(10)
    end
  
    it 'make top_up throw error if balance would be bigger than 90' do
      subject.top_up(90)
      expect{ subject.top_up(0.1) }.to raise_error('Balance cannot exceed 90')
    end
    it 'make top_up throw error if balance would be bigger than new limit' do
      maximum_balance = Oystercard::LIMIT_CONST
      subject.top_up(maximum_balance)
      expect{ subject.top_up(1) }.to raise_error("Balance cannot exceed #{maximum_balance}")
    end
  end


  describe '#in_journey' do
    it 'starts not in a journey' do
      expect(subject.in_journey?).to eq(false)
    end
  end
  describe '#touch_in' do

    let(:entry_station){double :entry_station}
    let(:exit_station){double :exit_station}

    it 'touching in with station at param sets instance variable to param' do
      subject.top_up(5)
      subject.touch_in(entry_station)
      expect(subject.entry_station).to eq(entry_station)
    end
    it 'after touching in journey set to true' do
      subject.top_up(1)
      subject.touch_in(entry_station)
      expect(subject.in_journey?).to eq(true)
    end

    it 'will fail is #touch_in is run with @balance less than 1' do
      expect{ subject.touch_in(entry_station) }.to raise_error('Not enough money on card')
    end
  end
   
  describe 'touch_out' do 

    let(:entry_station){double :entry_station}
    let(:exit_station){double :exit_station}
    
    it 'after touching out journey set to false' do
      subject.top_up(1)
      subject.touch_in(entry_station)
      subject.touch_out(exit_station)
      expect(subject.in_journey?).to eq(false)
    end
    it 'touching out reduces balance by min fare' do 
      subject.top_up(5)
      subject.touch_in(entry_station)
      subject.touch_out(exit_station)
      expect(subject.balance).to eq(4)
    end
    it 'touching out reduces by min fare' do 
      subject.top_up(5)
      subject.touch_in(entry_station)
      expect{ subject.touch_out(exit_station) }.to change{ subject.balance }.by(-Oystercard::MINIMUM_CHARGE)
    end
  end
  describe '@journeys' do
    let(:entry_station){double :entry_station}
    let(:exit_station){double :exit_station}
    let(:journey){ {entry_station: entry_station, exit_station: exit_station} }

    it 'has an empty list of journeys by default' do
      expect(subject.journeys).to be_empty
    end
    it 'stores a journey' do
      subject.top_up(5)
      subject.touch_in(entry_station)
      subject.touch_out(exit_station)
      expect(subject.journeys).to include(journey)
    end
  end
end