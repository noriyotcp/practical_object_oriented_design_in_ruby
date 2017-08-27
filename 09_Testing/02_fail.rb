class Wheel
  attr_reader :rim, :tire

  def initialize(rim, tire)
    @rim  = rim
    @tire = tire
  end

  def width # 以前はdiameter
    rim + (tire * 2)
  end

  # ...
end

class Gear
  attr_accessor :chainring, :cog, :wheel

  def initialize(args)
    @chainring = args[:chainring]
    @cog = args[:cog]
    @rim = args[:rim]
    @wheel = args[:wheel]
  end

  def gear_inches
    # 'wheel' 変数内のオブジェクトが
    # 'Diameterizable' ロールを担う
    ratio * wheel.diameter # 名前をwidth に変更するのを忘れていた！
  end

  def ratio
    chainring / cog.to_f
  end
  # ...
end

require 'test/unit'

class DiameterDouble
  def diameter
    10
  end
end

# class WheelTest < Test::Unit::TestCase
#   def test_calculates_diameter
#     wheel = Wheel.new(26, 1.5)

#     # https://docs.ruby-lang.org/ja/2.0.0/method/MiniTest=3a=3aAssertions/i/assert_in_delta.html
#     # assert_in_delta(expected, actual, delta = 0.001, message = nil) -> true[permalink][rdoc]
#     # 期待値と実際の値の差の絶対値が与えられた絶対誤差以下である場合、検査にパスしたことになります。
#     assert_in_delta(29, wheel.diameter, 0.01)
#     # Error: test_calculates_diameter(WheelTest): NoMethodError: undefined method `diameter' for #<Wheel:0x007fcc6e087978 @rim=26, @tire=1.5>
#   end
# end

class GearTest < Test::Unit::TestCase
  def test_calculates_gear_inches
    gear = Gear.new(chainring: 52,
                    cog: 11,
                    wheel: DiameterDouble.new)
    assert_in_delta(47.27, gear.gear_inches, 0.01)
    # DiameterDouble を注入しているので、テストが通ってしまう
  end
end
