# BicycleはPartsをhas-aの関係で持つ、sparesをpartsに委譲
class Bicycle
  attr_reader :size, :parts

  def initialize(args={})
    @size = args[:size]
    @parts = args[:parts]
  end

  def spares
    parts.spares
  end
end

class Parts
  attr_reader :chain, :tire_size

  def initialize(args={})
    @chain = args[:chain] || default_chain
    @tire_size = args[:tire_size] || default_tire_size
    post_initialize(args)
  end

  # サブクラスはオーバーライド可能
  def post_initialize(args)
    nil
  end

  def spares
    {tire_size: tire_size, chain: chain}.merge(local_spares)
  end

  def local_spares
    {}
  end

  def default_chain
    '10-speed'
  end

  def default_tire_size
    raise NotImplementedError, "This #{self.class} cannnot respond to:"
  end
end

# PartsはRoadBikePartsとMountainBikePartsというサブクラスを持つ
class RoadBikeParts < Parts
  attr_reader :tape_color

  def post_initialize(args)
    @tape_color = args[:tape_color]
  end

  def local_spares
    {tape_color: tape_color}
  end

  def default_tire_size
    '23'
  end
end

class MountainBikeParts < Parts
  attr_reader :front_shock, :rear_shock

  def post_initialize(args)
    @front_shock = args[:front_shock]
    @rear_shock = args[:rear_shock]
  end

  def local_spares
    {rear_shock: rear_shock}
  end

  def default_tire_size
    '2.1'
  end
end

road_bike = Bicycle.new(size: 'M', parts: RoadBikeParts.new(tape_color: 'red'))
puts road_bike.size
puts road_bike.spares #=> {:tire_size=>"23", :chain=>"10-speed", :tape_color=>"red"}

mountain_bike = Bicycle.new(size: 'S', parts: MountainBikeParts.new(front_shock: 'Manitou', rear_shock: 'Fox'))
puts mountain_bike.size
puts mountain_bike.spares

class RecumbentBikeParts < Parts
  attr_reader :flag

  def post_initialize(args)
    @flag = args[:flag]
  end

  def local_spares
    {flag: flag}
  end

  def default_chain
    '9-speed'
  end

  def default_tire_size
    '28'
  end
end

bent = RecumbentBikeParts.new(flag: 'tall and orange')
puts bent.spares
# {:tire_size=>"28", :chain=>"9-speed", :flag=>"tall and orange"}
