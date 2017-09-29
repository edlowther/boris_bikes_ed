class DockingStation

  attr_reader :docked_bikes, :capacity

  def initialize(capacity = 20)
    @docked_bikes = []
    @capacity = capacity
  end

  def release_bike
    raise 'No bike available' if empty?
    first_working_bike = @docked_bikes.select { |docked_bike| docked_bike.working }.shift
    if first_working_bike
      @docked_bikes.delete_at(@docked_bikes.index(first_working_bike))
      return first_working_bike
    end
    raise 'No working bikes'
  end

  def dock bike
    raise 'Docking station full' if full?
    @docked_bikes << bike
  end

  private
  def full?
    @docked_bikes.length >= @capacity
  end

  def empty?
    @docked_bikes.length == 0
  end
end
