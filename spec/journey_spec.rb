require 'journey'

describe Journey do
  describe '#in_journey' do
    it 'starts not in a journey' do
      expect(subject.in_journey?).to eq(false)
    end
  end
  let(:entry_station){double :entry_station}
  describe 'checking entry_station is set after touch_in' do
    it 'saves entry_station as instance variable' do
      oystercard = Oystercard.new
      oystercard.top_up(5)
      oystercard.touch_in(entry_station)
      expect(oystercard.journey.entry_station).to eq(entry_station)
    end
  end
  describe '@fare' do
    let(:entry_station){double :entry_station}
    let(:exit_station){double :exit_station}
    it 'checks .fare return PENALTY_FARE on init' do
      expect(subject.fare).to eq(Journey::PENALTY_FARE)
    end
    it 'gives minumim charge on normal journey' do
      oystercard = Oystercard.new
      oystercard.top_up(5)
      oystercard.touch_in(entry_station)
      oystercard.touch_out(exit_station)
      expect(oystercard.journey.fare).to eq(Journey::MINIMUM_CHARGE)
    end
    it 'check balance is updated with fare amount' do
      oystercard = Oystercard.new
      oystercard.top_up(20)
      oystercard.touch_in(entry_station)
      expect{ oystercard.touch_out(exit_station) }.to change{oystercard.balance}.by(-subject.fare)
    end
    it 'check fare is penalty on no touch out' do
      oystercard = Oystercard.new
      oystercard.top_up(20)
      oystercard.touch_in(entry_station)
      expect(oystercard.journey.fare).to eq(Journey::PENALTY_FARE)
    end
  end


end