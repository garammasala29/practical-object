# ダックを見逃す
# Tripのprepareメソッドの引数mechanicはMechanicクラスは別に参照されていない。どんなものでも良い
class Trip
  attr_reader :bicycles, :customers, :vechicle
  def prepare(mechanic)
    mechanic.prepare_bicycles(bicycles)
  end
  # ...
end

class Mechanic
  def prepare_bicycles(bicycles)
    bicycles.each do |bicycle|
      prepare_bicycles(bicycle)
    end
  end

  def prepare_bicycles(bicycle)
    # ...
  end
end
