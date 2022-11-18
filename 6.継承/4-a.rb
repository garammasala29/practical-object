# MountainBikeが全ての共通の振る舞いを含んでる状態
class Bicycle
  # このクラスはもはや空
  # コードは全てRoadBikeへ移行
end

class RoadBike < Bicycle
  # 今はBicycleのサブクラス
  # かつてのBicycleクラスからのコードを全て含む
  attr_reader :size, :tape_color

  def initialize(args)
    @size = args[:size]
    @tape_color = args[:tape_color]
  end

  # 全ての自転車はデフォルト値、同じタイヤサイズとチェーンサイズを持つ
  def spares
    {chain: '10-speed', tire_size: '23', tape_color: tape_color}
  end
end

class MountainBike < Bicycle
  # Bicycleのサブクラスのまま
  attr_reader :front_shock, :rear_shock
  def initialize(args)
    @front_shock = args[:front_shock]
    @rear_shock = args[:rear_shock]
  end

  def spares
    super.merge(rear_shock: rear_shock)
  end
end

road_bike = RoadBike.new(size: 'M', tape_color: 'red')
puts road_bike.size

mountain_bike = MountainBike.new(size: 'S', front_shock: 'Manitou', rear_shock: 'Fox')
puts mountain_bike.size
# undefined method `size' for #<MountainBike:0x00000001025bbaf0 @front_shock="Manitou", @rear_shock="Fox"> (NoMethodError)
