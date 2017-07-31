chainring = 52 # 歯数
cog = 11 # コグ
ratio = chainring / cog.to_f # ギヤ比 １回漕ぐことの車輪の回転数
puts ratio # => 4.7272727272727275

chainring = 30
cog = 27
ratio = chainring / cog.to_f
puts ratio # => 1.1111111111111112

class Gear
  attr_reader :chainring, :cog

  def initialize(chainring, cog)
    @chainring = chainring
    @cog = cog
  end

  def ratio
    chainring / cog.to_f
  end
end

puts Gear.new(52, 11).ratio
puts Gear.new(30, 27).ratio
