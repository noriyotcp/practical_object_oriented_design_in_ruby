class Bicycle
  attr_reader :size, :chain, :tire_size

  def initialize(args={})
    @size = args[:size]
    @chain = args[:chain] || default_chain
    @tire_size = args[:tire_size] || default_tire_size
    post_initialize(args) # Bicycle では送信と...
  end

  def post_initialize(args) # ...実装の両方を行う
    nil
  end

  def default_tire_size
    raise NotImplementedError, "This #{self.class} cannot respond to:"
  end

  def spares
    { tire_size: tire_size, chain: chain }.merge(local_spares)
  end

  # サブクラスがオーバーライドするためのフック
  def local_spares
    {}
  end

  def default_chain
    '10-speed'
  end
end

class RoadBike < Bicycle
  attr_reader :tape_color

  def post_initialize(args) # RoadBikeでは任意でオーバーライドできる
    @tape_color = args[:tape_color]
  end

  def local_spares
    { tape_color: tape_color }
  end

  def default_tire_size # サブクラスの初期値
    '23'
  end
end

class MountainBike < Bicycle
  attr_reader :front_shock, :rear_shock

  def post_initialize(args)
    @front_shock = args[:front_shock]
    @rear_shock = args[:rear_shock]
  end

  def default_tire_size # サブクラスの初期値
    '2.1'
  end

  def local_spares
    { front_shock: front_shock, rear_shock: rear_shock }
  end
end

class RecumbentBike < Bicycle
  attr_reader :flag

  def post_initialize(args)
    @flag = args[:flag]
  end

  def local_spares
    { flag: flag }
  end

  def default_chain
    '9-speed'
  end

  def default_tire_size
    '28'
  end
end

class StubbedBike < Bicycle
  def default_tire_size
    0
  end

  def local_spares
    { saddle: 'painful' }
  end
end

require 'minitest/autorun'

module BicyleInterfaceTest
  def test_responds_to_default_tire_size
    assert_respond_to(@object, :default_tire_size)
  end

  def test_responds_to_default_chain
    assert_respond_to(@object, :default_chain)
  end

  def test_responds_to_chain
    assert_respond_to(@object, :chain)
  end

  def test_responds_to_size
    assert_respond_to(@object, :size)
  end

  def test_responds_to_tire_size
    assert_respond_to(@object, :tire_size)
  end

  def test_responds_to_spares
    assert_respond_to(@object, :spares)
  end
end

module BicycleSubclassTest
  def test_responds_to_post_initialize
    assert_respond_to(@object, :post_initialize)
  end

  def test_responds_to_local_spares
    assert_respond_to(@object, :local_spares)
  end

  def test_responds_to_default_tire_size
    assert_respond_to(@object, :default_tire_size)
  end
end

class BicyleTest < Minitest::Test
  include BicyleInterfaceTest

  # initialize メソッドで tire_size がなければ default_tire_size をセットするようになっているが
  # それはサブクラスでオーバーライドしなければならない
  # ここで引数を与えないと死んでしまう
  def setup
    @bike = @object = Bicycle.new({tire_size: 0})
    @stubbed_bike = StubbedBike.new
  end

  def test_forces_subclasses_to_implement_default_tire_size
    assert_raises(NotImplementedError) { @bike.default_tire_size }
  end

  def test_includes_local_spares_in_spares
    assert_equal @stubbed_bike.spares, { tire_size: 0, chain: '10-speed', saddle: 'painful' }
  end
end

class RoadBikeTest < Minitest::Test
  include BicyleInterfaceTest
  include BicycleSubclassTest

  def setup
    @bike = @object = RoadBike.new(tape_color: 'red')
  end

  def test_puts_tape_color_in_local_spares
    assert_equal 'red', @bike.local_spares[:tape_color]
  end
end

class MountainBikeTest < Minitest::Test
  include BicyleInterfaceTest
  include BicycleSubclassTest

  def setup
    @bike = @object = MountainBike.new
  end
end

class StubbedBikeTest < Minitest::Test
  include BicycleSubclassTest

  def setup
    @object = StubbedBike.new
  end
end
