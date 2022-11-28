road_config = [['chain', '10-speed'], ['tire_size', '23'], ['tape_color', 'red']]
mountain_config = [['chain', '10-speed'], ['tire_size', '2.1'], ['front_shock', 'Manitou', false], ['rear_shock', 'Fox']]

# PartクラスとPartsFactoryは重複しているので削除
# class Part
#   attr_reader :name, :description, :needs_spare

#   def initialize(args)
#     @name = args[:name]
#     @description = args[:description]
#     @needs_spare = args.fetch(:needs_spare, true)
#   end
# end

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

p PartsFactory.build(road_config)
#=> <Parts:0x0000000101396e60 @parts=[#<Part:0x00000001013978d8 @name="chain", @description="10-speed", @needs_spare=true>, #<Part:0x0000000101397388 @name="tire_size", @description="23", @needs_spare=true>, #<Part:0x0000000101396ed8 @name="tape_color", @description="red", @needs_spare=true>]>
p PartsFactory.build(mountain_config)
#=> <Parts:0x0000000101395e98 @parts=[#<Part:0x00000001013962f8 @name="chain", @description="10-speed", @needs_spare=true>, #<Part:0x00000001013960c8 @name="tire_size", @description="2.1", @needs_spare=true>, #<Part:0x0000000101395f88 @name="front_shock", @description="Manitou", @needs_spare=false>, #<Part:0x0000000101395f10 @name="rear_shock", @description="Fox", @needs_spare=true>]>
# リファクタリング成功、コードが完結に
