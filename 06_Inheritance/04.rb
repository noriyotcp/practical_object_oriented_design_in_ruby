class Bicycle
  attr_reader :size, :chain, :tire_size

  def initialize(args={})
    @size = args[:size]
    @chain = args[:chain] || default_chain
    @tire_size = args[:tire_size] || default_tire_size
  end

  def default_chain #=> 共通の初期値
    '10-speed'
  end

  def default_tire_size
    raise NotImplementedError, "This #{self.class} cannot respond to:"
  end
end

class RoadBike < Bicycle
  attr_reader :tape_color

  def initialize(args)
    @tape_color = args[:tape_color]
    super(args)
  end

  def default_tire_size #=> サブクラスの初期値
    '23'
  end

  def spares
    {
      chain: '10-speed',
      tire_size: '23',
      tape_color: tape_color
    }
  end
end

class MountainBike < Bicycle
  attr_reader :front_shock, :rear_shock

  def initialize(args)
    @front_shock = args[:front_shock]
    @rear_shock = args[:rear_shock]
    super(args)
  end

  def default_tire_size #=> サブクラスの初期値
    '2.1'
  end

  def spares
    super.merge(front_shock: front_shock, rear_shock: rear_shock)
  end
end

class RecumbentBike < Bicycle
  def default_chain
    '9-speed'
  end
end

# bent = RecumbentBike.new
#=> `default_tire_size': This RecumbentBike cannot respond to: (NotImplementedError)

road_bike = RoadBike.new(size: 'M', tape_color: 'red')
p road_bike.tire_size #=> "23"
p road_bike.chain #=> "10-speed"

mountain_bike = MountainBike.new(
                size: 'S',
                front_shock: 'Manitou',
                rear_shock: 'Fox')

p mountain_bike.tire_size #=> "2.1"
p mountain_bike.chain #=> "10-speed"

