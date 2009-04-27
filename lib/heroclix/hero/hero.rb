module Heroclix
  class Hero
    attr_reader :name, :description, :clicks, :max_health, :all_powers
    
    def initialize(name, combat_values, description = nil)
      @name, @combat_values, @description = name, combat_values, description
      @max_health = @combat_values.values.max{ |a,b| a.size <=> b.size}.size
      @all_powers = @combat_values.values.flatten.map do |current_value|
        Power.get(current_value.type, current_value.color)
      end.compact.uniq.sort
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
    
    def health
      max_health - clicks
    end
    
    def active_powers
      CombatValue::TYPES.map do |type| 
        current_value = @combat_values[type][clicks]
        Power.get(type, current_value.color)
      end.compact.sort
    end
    
  end
end