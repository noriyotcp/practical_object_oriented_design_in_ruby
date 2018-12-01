class Gear
  attr_reader :chainring, :cog, :wheel

  def initialize(chainring: 40, cog: 18, wheel:)
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

# chainringのデフォルト値が返ってくる
puts Gear.new(wheel: Wheel.new(26, 1.5)).chainring

puts Gear.new(chainring: 52,
              cog: 11,
              wheel: Wheel.new(26, 1.5)).gear_inches
