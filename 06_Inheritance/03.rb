class Bicycle
  attr_reader :size, :tape_color

  def initialize(args)
    @size = args[:size]
    @tape_color = args[:tape_color]
  end

  # 全ての自転車は、デフォルト値として同じタイヤサイズとチェーンサイズを持つ
  def spares
    {
      chain: '10-speed',
      tire_size: '23',
      tape_color: tape_color
    }
  end

  # 他にもメソッドがたくさん...
end

class MountainBike < Bicycle
  attr_reader :front_shock, :rear_shock

  def initialize(args)
    @front_shock = args[:front_shock]
    @rear_shock = args[:rear_shock]
    super(args)
  end

  def spares
    super.merge(front_shock: front_shock, rear_shock: rear_shock)
  end
end

mountain_bike = MountainBike.new(
                size: 'S',
                front_shock: 'Manitou',
                rear_shock: 'Fox')

p mountain_bike.size #=> "S"
p mountain_bike.spares
#=> {:chain=>"10-speed", :tire_size=>"23", :tape_color=>nil, :rear_shock=>"Fox"}
#=> :tire_size は間違い、:tape_color は不適切
