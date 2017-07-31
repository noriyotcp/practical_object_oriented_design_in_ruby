chainring = 52 # 歯数
cog = 11 # コグ
ratio = chainring / cog.to_f # ギヤ比 １回漕ぐことの車輪の回転数
puts ratio # => 4.7272727272727275

chainring = 30
cog = 27
ratio = chainring / cog.to_f
puts ratio # => 1.1111111111111112

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

puts Gear.new(52, 11, 26, 1.5).gear_inches # => 137.0909090909091
puts Gear.new(52, 11, 24, 1.25).gear_inches # => 125.27272727272728

# puts Gear.new(52, 11).ratio
# /practical_object_oriented_design_in_ruby/02_SRP/02.rb:14:in `initialize': wrong number of arguments (given 2, expected 4) (ArgumentError)
