require 'forwardable'

module Heroclix
  class Hero
    extend Forwardable
    
    attr_reader :name, :card, :base, :clicks
    def_delegators :@base, :range, :range_targets
      
    def self.all
      @heroes ||= Parser.all_heroes  
    end
    
    # returns a copy of a Hero to be used in a Game
    def self.get(name)
      all.select { |hero| hero.name == name }.first.dup
    end
    
    def initialize(name, combat_values, base = Base.new, card = nil)
      @name, @combat_values, @base, @card = name, combat_values, base, card
      @clicks = 0
    end
    
    def speed
      @combat_values[:speed][clicks]
    end
    
    def attack
      @combat_values[:attack][clicks]
    end

    def defense
      @combat_values[:defense][clicks]
    end

    def damage
      @combat_values[:damage][clicks]
    end

    def damage!(amount = 1)
      @clicks += amount
    end
    
    def heal!(amount = 1)
      @clicks -= amount
      reset! if @clicks < 0
    end

    def reset!
      @clicks = 0
    end
    
    def ko?
      CombatValue::TYPES.all? { |type| @combat_values[type][clicks].nil? }
    end

    def max_health
      @max_health ||= @combat_values.values.max{ |a,b| a.size <=> b.size}.size
    end
    
    def health
      max_health - clicks
    end
    
    def all_powers
      @all_powers ||= @combat_values.values.flatten.map do |current_value|
        Power.get(current_value.type, current_value.color)
      end.compact.uniq.sort
    end
    
    def active_powers
      CombatValue::TYPES.map do |type| 
        current_value = @combat_values[type][clicks]
        Power.get(type, current_value.color)
      end.compact.sort
    end
    
  end
end