chainring = 52 # 歯数
cog = 11
ratio = chainring / cog.to_f
puts ratio

chainring = 30
cog = 27
ratio = chainring / cog.to_f
puts ratio

# ギアインチ = ギア比 * 車輪の直径、ただし
# 車輪の直径 = リムの直径 + タイヤの厚みの2倍とする
class Gear
  attr_reader :chainring, :cog, :rim, :tire

  def initialize(chainring, cog, rim, tire)
    @chainring = chainring
    @cog = cog
    @rim = rim
    @tire = tire
  end

  def ratio
    chainring / cog.to_f
  end

  def gear_inches
    ratio * (rim + (tire * 2))
  end
end

puts Gear.new(52, 11, 26, 1.5).gear_inches #=> 137.0909090909091

# wrong number of arguments (given 2, expected 4) (ArgumentError)
# puts Gear.new(52, 11).ratio
# puts Gear.new(30, 27).ratio

