# Wheelの新しいインスタンス作成をgear_inchesからinitializeに移動
# ただGearが作られる時にWheelもつくられてしまう

class Gear
  attr_reader :chainring, :cog, :rim, :tire
  def initialize(chainring, cog, rim, tire)
    @chainring = chainring
    @cog = cog
    @wheel = Wheel.new(rim, tire)
  end

  def gear_inches
    ratio * wheel.diameter
  end
end
