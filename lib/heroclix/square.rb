module Heroclix
  class Square
    attr_reader :terrain

    def self.parse(character)
      terrain = \
        case character
        when ' '
          :empty
        when 'x'
          :wall
        when 'o'
          :clear
        when '+'
          :hindering
        when 'X'
          :blocking
        end
      Square.new(terrain)
    end
    
    def initialize(terrain)
      @terrain = terrain
    end
    
  end
end