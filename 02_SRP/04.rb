chainring = 52 # 歯数
cog = 11 # コグ
ratio = chainring / cog.to_f # ギヤ比 １回漕ぐことの車輪の回転数
puts ratio # => 4.7272727272727275

chainring = 30
cog = 27
ratio = chainring / cog.to_f
puts ratio # => 1.1111111111111112

class Gear
  attr_reader :chainring, :cog, :wheel

  def initialize(chainring, cog, wheel = nil)
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

@wheel = Wheel.new(26, 1.5)
puts @wheel.circumference # => 91.106186954104

puts Gear.new(52, 11, @wheel).gear_inches # => 137.0909090909091

puts Gear.new(52, 11).ratio # => 4.7272727272727275
