# prepareメソッドは引数が複数のPreparerであることを想定
class Trip
  attr_reader :bicycles, :customers, :vechicle
  def prepare(preparers)
    preparers.each do |preparer|
      preparer.prepare_trip(self)
    end
  end
end

class Mechanic
  def prepare_trip(trip)
    tirp.bicycles.each do |bicycles|
      prepare_bicycle(bicycle)
    end
  end

  # ...
end

class TripCoordinator
  def prepare_trip(trip)
    buy_food(trip.customers)
  end

  # ...
end

class Driver
  def prepare_trip(trip)
    vechicle = trip.vechicle
    gas_up(vechicle)
    fill_water_tank(vechicle)
  end

  # ...
end
