class Gear
  attr_reader :chainring, :cog, :wheel

  def initialize(args)
    args = defaults.merge(args)
    @chainring = args[:chainring]
    @cog = args[:cog]
    @wheel = args[:wheel]
  end

  def defaults
    { chainring: 40, cog: 18 }
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

puts Gear.new(wheel: Wheel.new(26, 1.5)).gear_inches
puts Gear.new(chainring: 52,
              cog: 11,
              wheel: Wheel.new(26, 1.5)).gear_inches
