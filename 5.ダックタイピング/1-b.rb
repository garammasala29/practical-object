# これだとTripのprepareは他のどこかの変更によって変更が強制される
class Trip
  attr_reader :bicycles, :customers, :vechicle
  def prepare(mechanic)
    prepares.each do |preparer|
      case preparer
      when Mechanic
        prepare.prepare_bicycles(bicycles)
      when TripCoordinator
        prepare.buy_food(customers)
      when Driver
        prepare.gas_up(vechicle)
        prepare.fill_water_tank(vechicle)
      end
    end
  end
end

class TripCoordinator
  def buy_food(customers)
    # ...
  end
end

class Driver
  def gas_up(vechicle)
    # ...
  end

  def fill_water_tank(vechicle)
    # ...
  end
end
