require 'van'

describe Van do
  let(:bike_1) { double(:bike, :working => true) }
  let(:bike_2) { double(:bike, :working => true) }
  let(:bike_3) { double(:bike, :working => true) }
  let(:bike_4) { double(:bike, :working => true) }
  let(:faulty_bike_1) { double(:bike, :working => false) }
  let(:faulty_bike_2) { double(:bike, :working => false) }
  let(:docking_station_1) { double(:docking_station, :docked_bikes => [bike_1, bike_2, faulty_bike_1, bike_3, faulty_bike_2, bike_4]) }
  let(:docking_station_2) { double(:docking_station, :docked_bikes => [bike_1, bike_2, faulty_bike_1, bike_3, faulty_bike_2, bike_4]) }
  let(:docking_station_3) { double(:docking_station, :docked_bikes => [bike_1, bike_2, faulty_bike_1, bike_3, faulty_bike_2, bike_4]) }

  it 'has an itinerary of docking stations to visit' do
    expect(subject.itinerary).to be_an Array
  end

  it 'initially has no docking stations to visit' do
    expect(subject.itinerary.length).to eq 0
  end

  it 'enables a system maintainer to add docking stations to the itinerary' do
    subject.add_docking_station docking_station_1
    subject.add_docking_station docking_station_2
    expect(subject.itinerary.length).to eq 2
  end

  it 'collects the broken bikes from a docking station' do
    subject.add_docking_station docking_station_1
    subject.collect_broken_bikes
    expect(subject.itinerary[0].docked_bikes.find { |docked_bike| !docked_bike.working }).to eq nil
  end

  it 'collects the broken bikes from all docking stations on its itinerary' do
    subject.add_docking_station docking_station_1
    subject.add_docking_station docking_station_2
    subject.add_docking_station docking_station_3
    subject.collect_broken_bikes
    all_bikes = []
    subject.itinerary.each do |docking_station|
      all_bikes += docking_station.docked_bikes
    end
    expect(all_bikes.find { |docked_bike| !docked_bike.working }).to eq nil
  end

  it 'retains broken bikes that it has collected from docking stations on its itinerary' do
    subject.add_docking_station docking_station_1
    subject.add_docking_station docking_station_2
    subject.add_docking_station docking_station_3
    subject.collect_broken_bikes
    expect(subject.collected_bikes.length).to eq 6
  end

  it 'gets the bikes fixed' do
    subject.add_docking_station docking_station_1
    subject.add_docking_station docking_station_2
    subject.add_docking_station docking_station_3
    subject.collect_broken_bikes
    subject.get_bikes_fixed
    expect(subject.collected_bikes.find { |bike| !bike.working }).to eq nil
  end


  # it 'distributes fixed bikes to docking stations on its itinerary' do
  #   subject.add_docking_station docking_station_1
  #   subject.add_docking_station docking_station_2
  #   subject.add_docking_station docking_station_3
  #   subject.collect_broken_bikes
  #   subject.distribute_fixed_bikes
  #   p subject.collected_bikes
  #   expect(subject.collected_bikes.length).to eq 0
  # end

end
