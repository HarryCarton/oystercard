require 'station'

describe Station do
  it 'checks station name' do
    station = Station.new('Big station', 1)
    expect(station.name).to eq('Big station')
  end
  it 'checks the zone' do
    station = Station.new('Big station', 1)
    expect(station.zone).to eq(1)
  end
end