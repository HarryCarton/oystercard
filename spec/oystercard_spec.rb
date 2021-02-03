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


  describe '@journey' do
    it 'starts not in a journey' do
      expect(subject.in_journey?).to eq(false)
    end
  end
  describe '#touch_in' do

    let(:station){double :station}
    it 'touching in with station at param sets instance variable to param' do
      subject.top_up(5)
      subject.touch_in(station)
      expect(subject.entry_station).to eq(station)
    end
    it 'after touching in journey set to true' do
      subject.top_up(1)
      subject.touch_in(station)
      expect(subject.in_journey?).to eq(true)
    end

    it 'will fail is #touch_in is run with @balance less than 1' do
      expect{ subject.touch_in(station) }.to raise_error('Not enough money on card')
    end
  end
   
  describe 'touch_out' do 

    let(:station){double :station}

    it 'after touching out journey set to false' do
      subject.top_up(1)
      subject.touch_in(station)
      subject.touch_out
      expect(subject.in_journey?).to eq(false)
    end
    it 'touching out reduces balance by min fare' do 
      subject.top_up(5)
      subject.touch_in(station)
      subject.touch_out
      expect(subject.balance).to eq(4)
    end
    it 'touching out reduces by min fare' do 
      subject.top_up(5)
      subject.touch_in(station)
      expect{ subject.touch_out }.to change{ subject.balance }.by(-Oystercard::MINIMUM_CHARGE)
    end
  end
end