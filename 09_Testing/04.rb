class Wheel
  attr_reader :rim, :tire

  def initialize(rim, tire)
    @rim  = rim
    @tire = tire
  end

  def diameter
    rim + (tire * 2)
  end

  # ...
end

class Gear
  # observer を追加
  attr_accessor :chainring, :cog, :wheel, :observer

  def initialize(args)
    @chainring = args[:chainring]
    @cog = args[:cog]
    @rim = args[:rim]
    @wheel = args[:wheel]
    @observer = args[:observer]
  end

  def gear_inches
    # 'wheel' 変数内のオブジェクトが
    # 'Diameterizable' ロールを担う
    ratio * wheel.diameter
  end

  def ratio
    chainring / cog.to_f
  end

  def set_cog(new_cog)
    @cog = new_cog
    changed
  end

  def set_chainring(new_chainring)
    @chainring = new_chainring
    changed
  end

  def changed
    observer.changed(chainring, cog)
  end
  # ...
end

require 'minitest/autorun'
require 'minitest/mock'

# 'Diameterizable' ロールの担い手を作る
class DiameterDouble
  def diameter
    10
  end
end

class WheelTest < Minitest::Test
  def setup
    @wheel = Wheel.new(26, 1.5)
  end

  def test_implements_the_diameterizable_interface
    assert_respond_to(@wheel, :diameter)
  end

  def test_calculates_diameter
    # wheel = Wheel.new(26, 1.5)

    # https://docs.ruby-lang.org/ja/2.0.0/method/MiniTest=3a=3aAssertions/i/assert_in_delta.html
    # assert_in_delta(expected, actual, delta = 0.001, message = nil) -> true[permalink][rdoc]
    # 期待値と実際の値の差の絶対値が与えられた絶対誤差以下である場合、検査にパスしたことになります。
    assert_in_delta(29, @wheel.diameter, 0.01)
  end
end

class GearTest < Minitest::Test
  def setup
    @observer = Minitest::Mock.new # mock を作成、observer の代わりに挿入
    @gear = Gear.new(chainring: 52,
                cog: 11,
                observer: @observer)

  end

  def test_notifies_observers_when_cogs_change
    @observer.expect(:changed, true, [52, 27]) # changed メッセージを受け取ることを期待する
    @gear.set_cog(27)
    @observer.verify # 確かに受け取ったことを確認
  end

  def test_notifies_observers_when_chainrings_change
    @observer.expect(:changed, true, [42, 11])
    @gear.set_chainring(42)
    @observer.verify
  end

  def test_calculates_gear_inches
    gear = Gear.new(chainring: 52,
                    cog: 11,
                    wheel: DiameterDouble.new)
    assert_in_delta(47.27, gear.gear_inches, 0.01)
  end
end
