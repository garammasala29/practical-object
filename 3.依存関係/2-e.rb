# 初期化の引数にハッシュ(args)を使う
class Gear
  attr_reader :chainring, :cog, :wheel
  def initialize(args)
    @chainring = args[:chainring]
    @cog = args[:cog]
    @wheel = args[:wheel]
  end
end

Gear.new(
  :chainring => 52,
  :cog => 11,
  :wheel => Wheel.new(26, 1.5)).gear_inches

# 冗長になるのは仕方ないけど、引数として渡されるhashのキー名への依存がある
