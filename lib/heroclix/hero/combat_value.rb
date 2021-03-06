module Heroclix
  class CombatValue
    include Comparable

    TYPES = [:speed, :attack, :defense, :damage]
    COLORS = %w[red orange yellow lime green blue darkblue purple brown black gray special]
    
    TYPE_SYMBOLS = %w[s a d *]
    
    attr_reader :value, :color, :type

    def self.from_string(type, string)
      value = string[/\d+/]
      color = string[/[a-zA-Z]+/]
      CombatValue.new(type, value.to_i, color)
    end


    def initialize(type, value, color)
      @type, @value, @color = type.to_sym, value, color
    end
      
    alias :to_i :value
    
    def to_s
      "#{TYPE_SYMBOLS[TYPES.index(type)]}#{value}#{' (' + color + ')' if color}"
    end
    
    def colored?
      color != nil
    end
    
    def power
      @power ||= Power.get(type, color)
    end
    
    def <=>(other)
      value <=> other.value
    end
  end
end