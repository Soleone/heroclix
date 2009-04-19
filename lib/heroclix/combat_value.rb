module Heroclix
  class CombatValue
    attr_reader :value, :color

    def self.from_string(string)
      color = string.gsub(/\d /, '')
      CombatValue.new(string.to_i, color.empty? ? nil : color)
    end
    

    def initialize(value, color)
      @value, @color = value, color
    end
    
    alias :to_i :value
  end
end