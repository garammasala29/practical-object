# sparesメソッドがごちゃごちゃしているので修正
class Bicycle
  attr_reader :size, :chain, :tire_size

  def initialize(args={})
    @size = args[:size]
    @chain = args[:chain] || default_chain
    @tire_size = args[:tire_size] || default_tire_size
  end

  # チェーンとタイヤサイズをsuperの送信と置き換えるだけ
  def spares
    {tire_size: tire_size, chain: chain}
  end

  def default_chain
    '10-speed'
  end

  def default_tire_size
    raise NotImplementedError, "This #{self.class} cannnot respond to:"
  end
end

class RoadBike < Bicycle
  attr_reader :tape_color

  def initialize(args)
    @tape_color = args[:tape_color]
    super(args)
  end

  def spares
    super.merge({type_color: tape_color})
  end

  def default_tire_size
    '23'
  end
end

class MountainBike < Bicycle
  attr_reader :front_shock, :rear_shock

  def initialize(args)
    @front_shock = args[:front_shock]
    @rear_shock = args[:rear_shock]
    super(args)
  end

  def spares
    super.merge({rear_shock: rear_shock})
  end

  def default_tire_size
    '2.1'
  end
end

road_bike = RoadBike.new(size: 'M', tape_color: 'red')
puts road_bike.tire_size
puts road_bike.chain

mountain_bike = MountainBike.new(size: 'S', front_shock: 'Manitou', rear_shock: 'Fox')
puts mountain_bike.tire_size
puts mountain_bike.chain

# ただ、これでは以下のトラップで引っかかる
class RecumbentBike < Bicycle
  attr_reader :flag

  def initialize(args)
    @flag = args[:flag]
  end

  def spares
    super.merge({flag: flag})
  end

  def default_chain
    '9-speed'
  end

  def default_tire_size
    '28'
  end
end

bent = p RecumbentBike.new(flag: 'tall and orange')
puts bent.spares
#=> {:tire_size=>nil, :chain=>nil, :flag=>"tall and orange"}
# tire_sizeとchainが初期化されていない
# super(args)を忘れたから
# これではサブクラスは依存している
