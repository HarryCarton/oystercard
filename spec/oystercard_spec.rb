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
  describe '#deduct' do
    it 'takes away a set amount from a card' do
      subject.top_up(45)
      subject.deduct(30)
      expect(subject.balance).to eq(15)
    end
  end

  describe '@journey' do
    it 'starts not in a journey' do
      expect(subject.journey).to eq(false)
    end
  end
  describe '#touch_in' do
    it 'after touching in journey set to true' do
      subject.top_up(1)
      subject.touch_in
      expect(subject.journey).to eq(true)
    end

    it 'will fail is #touch_in is run with @balance less than 1' do
      expect{ subject.touch_in }.to raise_error('Not enough money on card')
    end
  end
   
  describe 'touch_out' do 
    it 'after touching out journey set to false' do
      subject.top_up(1)
      subject.touch_in
      subject.touch_out
      expect(subject.journey).to eq(false)
    end
  end
end