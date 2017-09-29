class Van
  attr_reader :itinerary, :collected_bikes

  def initialize
    @itinerary = []
    @collected_bikes = []
  end

  def add_docking_station(docking_station)
    @itinerary << docking_station
  end

  def collect_broken_bikes
    @itinerary.each do |docking_station|
      @collected_bikes += docking_station.docked_bikes.select {|docked_bike| !docked_bike.working}
      docking_station.docked_bikes.reject! {|docked_bike| !docked_bike.working}
    end
  end

  def get_bikes_fixed
    @collected_bikes.each do |bike|
      p bike.working
      bike.working = true
    end
  end

  # def distribute_fixed_bikes
  #   @itinerary.each do |docking_station|
  #
  #     docking_station.docked_bikes.reject! {|docked_bike| !docked_bike.working}
  #   end
  # end
end
