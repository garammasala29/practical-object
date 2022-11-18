# これまでGearがWheel、diameterに依存していたが、WheelをGearやratioに依存を逆転
class Gear
  attr_reader :chainring, :cog
  def initialize(chainring, cog)
    @chainring = chainring
    @cog = cog
  end

  # 呼び出し側でdiameter引数を渡す
  def gear_inches(diameter)
    ratio * diameter
  end

  def ratio
    chainring / cog.to_f
  end
end

class Wheel
  attr_reader :rim, :tire, :gear
  def initialize(rim, tire, chainring, cog)
    @rim = rim
    @tire = tire
    @gear = Gear.new(chainring, cog)
  end

  def diameter
    rim + (tire * 2)
  end

  def gear_inches
    gear.gear_inches(diameter)
  end
end

puts Wheel.new(26, 1.5, 52, 11).gear_inches

# どちらに依存させてもよいが、アプリが変化していくと依存関係に侵食され変更は難しくなる
