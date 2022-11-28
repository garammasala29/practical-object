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

# Arrayのサブクラスにさせることでsizeやeach、sortなどArrayのメソッドを使えるようにする
class Parts < Array
  def spares
    select{ |part| part.needs_spare }
  end
end

class Part
  attr_reader :name, :description, :needs_spare

  def initialize(args)
    @name = args[:name]
    @description = args[:description]
    @needs_spare = args.fetch(:needs_spare, true)
  end
end

chain = Part.new(name: 'chain', description: '10-speed')
road_tire = Part.new(name: 'tire_size', description: '23')
tape = Part.new(name: 'tape_color', description: 'red')
mountain_tire = Part.new(name: 'tire_size', description: '2.1')
rear_shock = Part.new(name: 'rear_shock', description: 'Fox')
front_shock = Part.new(name: 'front_shock', description: 'Manitou', needs_spare: false)

road_bike = Bicycle.new(size: 'L', parts: Parts.new([chain, road_tire, tape]))
mountain_bike = Bicycle.new(size: 'L', parts: Parts.new([chain, mountain_tire, front_shock, rear_shock]))

combo_parts = (mountain_bike.parts + road_bike.parts)
p combo_parts.size #=> 7

# p combo_parts.spares
#=> undefined method `spares'
# spareの数を数えれてもその内容は理解していない

p mountain_bike.parts.class #=> Parts
p road_bike.parts.class #=> Parts
p combo_parts.class #=> Array

# 結果、見かけ上Arrayオブジェクトにしたのはいいけど、sparesは理解していない、インスタンスはまだ期待外れ
# 完璧な解決法はなくsizeメソッドを作るだけが最善策
