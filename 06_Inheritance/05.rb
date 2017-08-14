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

  def default_chain
    '10-speed'
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
end

class RoadBike < Bicycle
  attr_reader :tape_color

  def post_initialize(args) # RoadBikeでは任意でオーバーライドできる
    @tape_color = args[:tape_color]
  end

  def default_tire_size # サブクラスの初期値
    '23'
  end

  def local_spares
    { tape_color: tape_color }
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

bent = RecumbentBike.new(flag: 'tall and orange')
p bent.spares #=> {:tire_size=>"28", :chain=>"9-speed", :flag=>"tall and orange"}

road_bike = RoadBike.new(size: 'M', tape_color: 'red')
p road_bike.tire_size #=> "23"
p road_bike.chain #=> "10-speed"
p road_bike.spares #=> {:chain=>"10-speed", :tire_size=>"23", :tape_color=>"red"}

mountain_bike = MountainBike.new(
                size: 'S',
                front_shock: 'Manitou',
                rear_shock: 'Fox')

p mountain_bike.tire_size #=> "2.1"
p mountain_bike.chain #=> "10-speed"
p mountain_bike.spares #=> {:tire_size=>"2.1", :chain=>"10-speed", :front_shock=>"Manitou", :rear_shock=>"Fox"}
