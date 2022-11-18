# gear_inchesはWheelに対して明示的に参照していた
# Wheelの名前に変更があった時にgear_inchesメソッドも変更する必要があり
# class Gear
#   attr_reader :chainring, :cog, :rim, :tire
#   def initialize(chainring, cog, rim, tire)
#     @chainring = chainring
#     @cog = cog
#     @rim = rim
#     @tire = tire
#   end

#   def gear_inches
#     ratio * Wheel.new(rim, tire).diameter
#   end
# end

# Gear.new(52, 11, 26, 1.5).gear_inches

class Gear
  attr_reader :chainring, :cog, :wheel
  def initialize(chainring, cog, wheel)
    @chainring = chainring
    @cog = cog
    @wheel = wheel
  end

  def gear_inches
    ratio * wheel.diameter
  end
end

puts Gear.new(52, 11, Wheel.new(26, 1.5)).gear_inches
