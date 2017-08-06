# Gearが外部インターフェースの一部の場合
module SomeFramework
  class Gear
    attr_reader :chainring, :cog, :wheel
    # 引数が固定順番で指定されている
    def initialize(chainring, cog, wheel)
      @chainring = chainring
      @cog = cog
      @wheel = wheel
    end

    def ratio
      chainring / cog.to_f
    end

    def gear_inches
      ratio * wheel.diameter
    end
  end
end

# 外部のインターフェースをラップし、自身を変更から守る
module GearWrapper
  def self.gear(args)
    args = defaults.merge(args)
    SomeFramework::Gear.new(args[:chainring],
                            args[:cog],
                            args[:wheel])

  end

  def self.defaults
    { chainring: 40, cog: 18 }
  end
end

class Wheel
  attr_reader :rim, :tire

  def initialize(rim, tire)
    @rim = rim
    @tire = tire
  end

  def diameter
    rim + (tire * 2)
  end

  # タイヤの円周を求める
  def circumference
    diameter * Math::PI
  end
end

puts GearWrapper.gear(chainring: 52,
                      cog: 11,
                      wheel: Wheel.new(26, 1.5)).gear_inches

puts GearWrapper.gear(wheel: Wheel.new(26, 1.5)).gear_inches
