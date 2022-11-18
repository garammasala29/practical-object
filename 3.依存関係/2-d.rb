class Gear
  attr_reader :chainring, :cog, :wheel
  def initialize(chainring, cog, wheel)
    @chainring = chainring
    @cog = cog
    @wheel = wheel
  end
end

# 引数を正しい順番で渡す必要がある
Gear.new(52, 11, Wheel.new(26, 1.5)).gear_inches
