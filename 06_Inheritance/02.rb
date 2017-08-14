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

bike = Bicycle.new(size: 'M', tape_color: 'red')
p bike.size   #=> "M"
p bike.spares #=> {:chain=>"10-speed", :tire_size=>"23", :tape_color=>"red"}

class Bicycle
  attr_reader :style, :size, :tape_color,
              :front_shock, :rear_shock

  def initialize(args)
    @style = args[:style]
    @size = args[:size]
    @tape_color = args[:tape_color]
    @front_shock = args[:front_shock]
    @rear_shock = args[:rear_shock]
  end

  # 全ての自転車は、デフォルト値として同じタイヤサイズとチェーンサイズを持つ
  def spares
    if style == :road
      {
        chain: '10-speed',
        tire_size: '23', # milimeters
        tape_color: tape_color
      }
    else
      {
        chain: '10-speed',
        tire_size: '2.1', # inches
        rear_shock: rear_shock
      }
    end
  end

  # 他にもメソッドがたくさん...
end

bike = Bicycle.new(
        style: :mountain,
        size: 'S',
        front_shock: 'Manitou',
        rear_shock: 'Fox')

p bike.spares #=> {:chain=>"10-speed", :tire_size=>"2.1", :rear_shock=>"Fox"}
