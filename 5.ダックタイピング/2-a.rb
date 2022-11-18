# 隠れたダックを見つける
# 1.クラスで分岐するcase文
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

# kind_of?とis_a?を使ったもの(case文と同じ)
if prepare.kind_of?(Mechanic)
  prepare.prepare_bicycles(bicycle)
elsif prepare.kind_of?(TripCoordinator)
  prepare.buy_food(customers)
elsif prepare.kind_of?(Driver)
  prepare.gas_up(vechicle)
  preparer.fill_water_tank(vechicle)
end

# respond_to?を用いたもの
if prepare.responds_to?(:prepare_bicycles)
  prepare.prepare_bicycles(bicycle)
elsif prepare.responds_to?(:buy_food)
  prepare.buy_food(customers)
elsif prepare.responds_to?(:gas_up)
  prepare.gas_up(vechicle)
  preparer.fill_water_tank(vechicle)
end
