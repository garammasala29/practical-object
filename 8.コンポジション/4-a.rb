# 最終形態
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

require 'forwardable'
class Parts
  extend Forwardable
  # sizeとeachを自身の@partsに委譲、Enumerableをインクルード
  def_delegators :@parts, :size, :each
  include Enumerable

  def initialize(parts)
    @parts = parts
  end

  def spares
    select{ |part| part.needs_spare }
  end
end

require 'ostruct'
module PartsFactory
  def self.build(config, parts_class = Parts)
    parts_class.new(
      config.collect do |part_config|
        # part_class.new(name: part_config[0], description: part_config[1], needs_spare: part_config.fetch(2, true))
        create_part(part_config)
      end
    )
  end

  def self.create_part(part_config)
    OpenStruct.new(name: part_config[0], description: part_config[1], needs_spare: part_config.fetch(2, true))
  end
end

road_config = [['chain', '10-speed'], ['tire_size', '23'], ['tape_color', 'red']]
mountain_config = [['chain', '10-speed'], ['tire_size', '2.1'], ['front_shock', 'Manitou', false], ['rear_shock', 'Fox']]

road_bike = Bicycle.new(size: 'L', parts: PartsFactory.build(road_config))
p road_bike.spares
#=> [#<OpenStruct name="chain", description="10-speed", needs_spare=true>, #<OpenStruct name="tire_size", description="23", needs_spare=true>, #<OpenStruct name="tape_color", description="red", needs_spare=true>]
