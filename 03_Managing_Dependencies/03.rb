class Gear
  attr_reader :chainring, :cog

  def initialize(args)
    args = defaults.merge(args)
    @chainring = args[:chainring]
    @cog = args[:cog]
  end

  def defaults
    { chainring: 40, cog: 18 }
  end

  def ratio
    chainring / cog.to_f
  end

  def gear_inches(diameter)
    ratio * diameter
  end
end

class Wheel
  attr_reader :rim, :tire, :gear

  def initialize(args)
    args = defaults.merge(args)
    @rim = args[:rim]
    @tire = args[:tire]
    @gear = Gear.new(chainring: args[:chainring], cog: args[:cog])
  end

  def defaults
    { rim: 26, tire: 1.5, chainring: 52, cog: 11 }
  end

  def diameter
    rim + (tire * 2)
  end

  def gear_inches
    gear.gear_inches(diameter)
  end

  # タイヤの円周を求める
  def circumference
    diameter * Math::PI
  end
end

puts Wheel.new(rim: 30,
               tire: 1.0,
               chainring: 50,
               cog: 10).gear_inches

puts Wheel.new({}).gear_inches
