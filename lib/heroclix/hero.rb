module Heroclix
  class Hero
    attr_reader :name, :description, :clicks
    
    def initialize(name, combat_values, description = nil)
      @name, @combat_values, @description = name, combat_values, description
      @clicks = 0  
    end
    
    def speed
      @combat_values[:speed][@clicks]
    end
    
    def attack
      @combat_values[:attack][@clicks]
    end

    def defense
      @combat_values[:defense][@clicks]
    end

    def damage
      @combat_values[:damage][@clicks]
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
  end
end