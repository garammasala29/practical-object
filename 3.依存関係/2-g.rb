# モジュールを使う。よく分かっていない
module SomeFramework
  class Gear
    attr_reader :chainring, :cog, :wheel
    def initialize(args)
      @chainring = args[:chainring]
      @cog = args[:cog]
      @wheel = args[:wheel]
    end
  end
end

module GearWrapper
  def self.gear(args)
    SomeFramework::Gear.new(args[:chainring], args[:cog], args[:wheel])
  end
end

GearWrapper.gear(
  :chainring => 52,
  :cog => 11,
  :wheel => Wheel.new(26, 1.5)).gear_inches
