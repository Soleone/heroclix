module Heroclix
  class Position
    DIRECTIONS = %w[north south east west northeast northwest southeast southwest]

    # generate concenience methods for adjacent positions
    DIRECTIONS.each do |direction|
      define_method(direction) do |*args|
        amount   = args[0] || 1
        absolute = args[1] || false
        get(direction, amount, absolute)
      end
    end
    
    attr_reader :map, :x, :y
    
    def initialize(map, x, y)
      @map   = map
      @x, @y = x, y
    end

    # Get adjacent squares (only count relative squares)
    def get(direction, amount = 1, absolute = false)
      amount *= 2 if absolute
      y = case direction.to_s
      when /north/
        @y - amount 
      when /south/
        @y + amount
      else
        @y
      end
      x = case direction.to_s
      when /east/
        @x - amount
      when /west/
        @x + amount
      else
        @x
      end
      @map[x, y]
    end
    
    alias :above :north
    alias :below :south
    alias :left :east
    alias :right :west

    def adjacent_squares
      [northwest, north, northeast, west, east, southwest, south, southeast].compact
    end
    
    def relative
      Position.new((@x + 1) / 2, (@y + 1) / 2)
    end


    def to_s
      "[#{@x}, #{@y}]"   
    end
  end
end