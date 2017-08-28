# ギアインチ = ギア比 * 車輪の直径、ただし
# 車輪の直径 = リムの直径 + タイヤの厚みの2倍とする
class Gear
  attr_reader :chainring, :cog, :wheel

  def initialize(chainring, cog, rim, tire)
    @chainring = chainring
    @cog = cog
    @wheel = Wheel.new(rim, tire)
  end

  # インスタンス変数は常にアクセサメソッドで包み、直接参照しないようにする
  def ratio
    chainring / cog.to_f
  end

  def gear_inches
    ratio * wheel.diameter
  end

  Wheel = Struct.new(:rim, :tire) do
    # 車輪の直径を計算
    def diameter
      rim + (tire * 2)
    end
  end
end

puts Gear.new(52, 11, 26, 1.5).gear_inches #=> 137.0909090909091


# attr_reader を使うと、Ruby は自動でインスタンス変数用の単純なラッパーメソッドを作る

def cog
  @cog
end

# データ構造の隠蔽
class ObscuringReferences
  attr_reader :data

  def initialize(data)
    @data = data
  end

  def diameters
    # 0はリム、1はタイヤ
    data.collect do |cell|
      cell[0] + (cell[1] * 2)
    end
  end

  # ... インデックスで配列の値を参照するメソッドが他にもたくさん
end

# リムとタイヤのサイズ (ここではミリメートル！) の２次元配列
@data = [[622, 20], [622, 23], [559, 30], [559, 40]]

class RevealingReferences
  attr_reader :wheels

  def initialize(data)
    @wheels = wheelify(data)
  end

  def diameters
    wheels.collect do |wheel|
      diameter(wheel)
    end
  end

  def diameter(wheel)
    wheel.rim + (wheel.tire * 2)
  end

  Wheel = Struct.new(:rim, :tire)
  def wheelify(data)
    data.collect do |cell|
      Wheel.new(cell[0], cell[1])
    end
  end
end
