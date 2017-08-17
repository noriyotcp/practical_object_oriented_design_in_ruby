require 'forwardable'

class Parts
  extend Forwardable
  def_delegators :@parts, :size, :each
  include Enumerable

  def initialize(parts)
    @parts = parts
  end

  def spares
    select { |part| part.needs_spare }
  end
end

road_config = [['chain', '10-speed'],
               ['tire_size', '23'],
               ['tape_color', 'red']]

mountain_config = [['chain', '10-speed'],
                   ['tire_size', '2.1'],
                   ['front_shock', 'Manitou', false],
                   ['rear_shock', 'Fox']]

require 'ostruct'

module PartsFactory
  def self.build(config, parts_class = Parts)

    parts_class.new(
      config.collect do |part_config|
        create_part(part_config)
      end
    )
  end

  def self.create_part(part_config)
    OpenStruct.new(name: part_config[0],
                   description: part_config[1],
                   needs_spare: part_config.fetch(2, true)) # array.fetch(index, default)
  end
end

p road_parts = PartsFactory.build(road_config)
#<Parts:0x007fba3e05a550 @parts=[#<OpenStruct name="chain", description="10-speed", needs_spare=true>, #<OpenStruct name="tire_size", description="23", needs_spare=true>, #<OpenStruct name="tape_color", description="red", needs_spare=true>]>

p mountain_parts = PartsFactory.build(mountain_config)
#<Parts:0x007fba3e0594c0 @parts=[#<OpenStruct name="chain", description="10-speed", needs_spare=true>, #<OpenStruct name="tire_size", description="2.1", needs_spare=true>, #<OpenStruct name="front_shock", description="Manitou", needs_spare=false>, #<OpenStruct name="rear_shock", description="Fox", needs_spare=true>]>
