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

# Partsは複数のPartオブジェクトを持つ(=Partsオブジェクトは複数のPartオブジェクトからコンポーズされる)
class Parts
  attr_reader :parts

  def initialize(parts)
    @parts = parts
  end

  def spares
    parts.select{ |part| part.needs_spare }
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

# パーツをたくさん作り、インスタンス変数に保存
chain = Part.new(name: 'chain', description: '10-speed')
road_tire = Part.new(name: 'tire_size', description: '23')
tape = Part.new(name: 'tape_color', description: 'red')
mountain_tire = Part.new(name: 'tire_size', description: '2.1')
rear_shock = Part.new(name: 'rear_shock', description: 'Fox')
front_shock = Part.new(name: 'front_shock', description: 'Manitou', needs_spare: false)

# ここのPartオブジェクトをPartsにひとまとめにしてグループ化できる
# ロードバイクのPartをロードバイクのPartsにまとめる
road_bike_parts = Parts.new([chain, road_tire, tape])

# Bicycleを作る際に、その場でPartsオブジェクトを作る
road_bike = Bicycle.new(size: 'L', parts: Parts.new([chain, road_tire, tape]))
puts road_bike.size
p road_bike.spares
#=> [#<Part:0x0000000102990bf8 @name="chain", @description="10-speed", @needs_spare=true>, #<Part:0x0000000102990978 @name="tire_size", @description="23", @needs_spare=true>, #<Part:0x0000000102990590 @name="tape_color", @description="red", @needs_spare=true>]

puts road_bike.spares.size
#=> 3
puts road_bike.parts.size
#=> undefined method `size'

# sparesは配列を返すが、partsはPartsのインスタンスを返す。ただ配列を持っているだけ

# def size
#   part.size
# end
# こんな改善できるが、内部配列のsizeを返すようにしただけでeachやsortなどの他のArrayメソッドは使えない
