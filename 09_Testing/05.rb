# 第５章のコード
class Mechanic
  def prepare_trip(trip)
    trip.bicycles.each do |bicycle|
      prepare_bicycle(bicycle)
    end
  end

  def prepare_bicycle(bicycle)
    # ...
  end
end

class TripCoordinator
  def prepare_trip(trip)
    buy_food(trip.customers)
  end

  def buy_food(customers)
    # ...
  end
end

class Driver
  def prepare_trip(trip)
    vehicle = trip.vehicle
    gas_up(vehicle)
    fill_water_tank(vehicle)
  end

  def gas_up(vehicle)
    # ...
  end

  def fill_water_tank(vehicle)
    # ...
  end
end

class Trip
  attr_reader :bicycles, :customers, :vehicle

  def prepare(preparers)
    preparers.each do |preparer|
      preparer.prepare_trip(self)
    end
  end
end

require 'minitest/autorun'

module PreparerInterfaceTest
  def test_implements_the_preparer_interface
    assert_respond_to(@object, :prepare_trip)
  end
end

class MechanicTest < Minitest::Test
  include PreparerInterfaceTest

  def setup
    @mechanic = @object = Mechanic.new
  end

  # @mechanic に依存する他のテスト
end

class TripCoordinatorTest < Minitest::Test
  include PreparerInterfaceTest

  def setup
    @trip_coordinator = @object = TripCoordinator.new
  end
end

class DriverTest < Minitest::Test
  include PreparerInterfaceTest

  def setup
    @driver = @object = Driver.new
  end
end

require 'minitest/mock'

class TripTest < Minitest::Test
  def test_requires_trip_preparation
    @preparer = Minitest::Mock.new
    @trip = Trip.new
    @preparer.expect(:prepare_trip, nil, [@trip])
    @trip.prepare([@preparer])
    @preparer.verify
  end
end

# 9.2 のテストをもとにする
require 'test/unit'

module DiameterizableInterfaceTest
  def test_implements_the_diameterizable_interface
    assert_respond_to(@object, :width)
  end
end

class Wheel
  attr_reader :rim, :tire

  def initialize(rim, tire)
    @rim  = rim
    @tire = tire
  end

  def width
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
    ratio * wheel.width
  end

  def ratio
    chainring / cog.to_f
  end
  # ...
end

# 'Diameterizable' ロールの担い手を作る
class DiameterDouble
  def width
    10
  end
end

class DiameterDoubleTest < Minitest::Test
  include DiameterizableInterfaceTest

  # 当該のテストコードが、このテストが期待するインターフェースを守ることを証明する
  def setup
    @object = DiameterDouble.new
  end
end

class GearTest < Minitest::Test
  def test_calculates_gear_inches
    gear = Gear.new(chainring: 52,
                    cog: 11,
                    wheel: DiameterDouble.new)
    assert_in_delta(47.27, gear.gear_inches, 0.01)
  end
end


class WheelTest < Minitest::Test
  include DiameterizableInterfaceTest

  def setup
    @wheel = @object = Wheel.new(26, 1.5)
  end

  def test_calculates_diameter
    # assert_in_delta(29, @wheel.width, 0.01)
  end
end
