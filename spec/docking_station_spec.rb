require 'docking_station'

describe DockingStation do
  let(:bike) { double(:bike, :working => true) }
  let(:faulty_bike) { double(:faulty_bike, :working => false) }

  it 'has a method release_bike that returns a bike' do
    subject.dock bike
    expect(subject.release_bike).to eq bike
  end

  it 'has a method release_bike that returns a working bike' do
    subject.dock bike
    expect(subject.release_bike.working).to eq true
  end

  it 'has a method dock that accepts a bike' do
    subject.dock bike
    expect(subject.docked_bikes[0]).to eq bike
  end

  it 'enables users to check a faulty bike that has been docked' do
    subject.dock faulty_bike
    expect(subject.docked_bikes[0].working).to eq false
  end

  it 'enables users to check a working bike that has been docked' do
    subject.dock bike
    expect(subject.docked_bikes[0].working).to eq true
  end

  it 'enables users to release the bike that has been docked' do
    subject.dock bike
    expect(subject.release_bike).to eq bike
  end

  it 'raises an error if a user tries to release a bike when there is no bike' do
    expect{subject.release_bike}.to raise_error('No bike available')
  end

  it 'raises an error if a user tries to dock a bike when there is already a bike' do
    expect{(subject.capacity + 1).times { subject.dock double(:bike) }}.to raise_error('Docking station full')
  end

  it 'accepts a value for the maximum capacity of bikes' do
    station = DockingStation.new(10)
    expect(station.capacity).to eq 10
  end

  it 'defaults to a capacity of 20 if no other capacity is passed' do
    expect(subject.capacity).to eq 20
  end

  it 'releases a working bike if there is one' do
    15.times do
      subject.dock [bike, faulty_bike].sample
    end
    subject.dock bike #aka there is definitely a working bike in the array
    expect(subject.release_bike.working).to eq true
  end

  it 'reduces the number of bikes by one if a bike is released' do
    16.times do
      subject.dock bike
    end
    subject.release_bike
    expect(subject.docked_bikes.length).to eq 15
  end

  it 'does not release a bike if all the docked bikes are faulty' do
    16.times do
      subject.dock faulty_bike
    end
    expect{subject.release_bike}.to raise_error 'No working bikes'
  end

  it 'docks bikes whether faulty or not' do
    subject.dock bike
    subject.dock faulty_bike
    expect(subject.docked_bikes.length).to eq 2
  end

end
