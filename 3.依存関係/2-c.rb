# Wheelの作成を隔離、必要なときまでWheelインスタンスは作成しない

class Gear
  attr_reader :chainring, :cog, :rim, :tire
  def initialize(chainring, cog, rim, tire)
    @chainring = chainring
    @cog = cog
    @rim = rim
    @tire = tire
  end

  def gear_inches
    ratio * wheel.diameter
  end

  def wheel
    @wheel ||= Wheel.new(rim, tire)
  end
end

# 複雑なメソッドになるなら外部的な依存を取り除き、メソッド内にカプセル化する
# def gear_inches
#   複雑な計算 * diameter
# end

# def diameter
#   wheel.diameter
# end
