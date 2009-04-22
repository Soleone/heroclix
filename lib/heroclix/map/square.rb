require 'forwardable'

module Heroclix
  class Square
    extend Forwardable
    
    CHARACTERS = %w[. x o + X]
    TYPES = [:empty, :wall, :clear, :hindering, :blocking]
    
    attr_reader :terrain, :position
    
    def_delegator :@position, :adjacent_squares
    
    def self.parse(character, position)
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
      Square.new(terrain, position)
    end
    
    # Square belongs on a map, knows where it is and knows about other squares
    def initialize(terrain, position)
      @terrain, @position = terrain, position
    end
    
    # can't be occupied by a Hero
    def border?
      terrain == :empty or terrain == :wall
    end
    
    def change_to(new_terrain)
      @terrain = new_terrain
    end
    
    def to_s
      "#{terrain} #{position}"
    end    
  end
end