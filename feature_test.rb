require './lib/docking_station'
require './lib/van'
require './lib/garage'

van = Van.new
garage = Garage.new

van.collect_broken_bikes
garage.fix_bikes
van.distribute_fixed_bikes
