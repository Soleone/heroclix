module Heroclix
  class Square
    CHARACTERS = %w[. x o + X]
    TYPES = [:empty, :wall, :clear, :hindering, :blocking]

    DIRECTIONS = %w[north south east west northeast northwest southeast southwest]

    # generate convenience methods for adjacent positions
    DIRECTIONS.each do |direction|
      define_method(direction) do |*args|
        amount   = args[0] || 1
        absolute = args[1] || false
        get(direction, amount, absolute)
      end
    end
    
    attr_reader :terrain, :map, :x, :y    
    
    def self.parse(character, map, x, y)
      terrain = \
        case character
        when '.'
          :empty
        when 'x'
          :wall
        when 'o'
          :clear
        when '+'
          :hindering
        when 'X'
          :blocking
        else
          raise ArgumentError.new("Invalid text character for Square: \"#{character}\" - must be one of \"#{CHARACTERS.join}\"")
        end
      square_sub_class = terrain == :empty || terrain == :wall ? WallSquare : TerrainSquare
      square_sub_class.new(terrain, map, x, y)
    end
    
    
    # Square belongs on a map, knows where it is and knows about other squares
    def initialize(terrain, map, x, y)
      @terrain, @map = terrain, map
      @x, @y = x, y
    end
    
    # can't be occupied by a Hero
    def border?
      terrain == :empty or terrain == :wall
    end
    
    def change_to!(new_terrain)
      @terrain = new_terrain
    end

    
    # Get adjacent squares (only count relative squares)
    def get(direction, amount = 1, absolute = false)
      amount *= 2 unless absolute
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
        @x + amount
      when /west/
        @x - amount
      else
        @x
      end
      @map.get(x, y, :absolute)
    end
    
    alias :above :north
    alias :below :south
    alias :left :east
    alias :right :west

    def adjacent_squares
      [northwest, north, northeast, west, east, southwest, south, southeast].compact
    end

    # TODO: can this really be computed? And is it different for :terrain or :wall square?
    def relative(mode = :terrain)
      modifier = mode == :terrain ? -1 : 1
      Position.new(map, (x + modifier)/2, (y + modifier)/2)
    end

    def to_s
      "#{terrain} [#{x}, #{y}]"
    end
    
    def inspect
      to_s
    end
    
    def to_a
      [x, y]
    end
    
    # returns character representation (reverse to parse)
    def chr
      CHARACTERS[TYPES.index(terrain)]
    end

  end
end