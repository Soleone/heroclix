module Heroclix
  # The base of the figure with some basic abilities.
  class Base
    SYMBOLS = {
      :speed   => %w[normal flight swim normal-transport flight-transport swim-transport],
      :attack  => %w[normal duo sharpshooter],
      :defense => %w[normal indomitable],
      :damage  => %w[normal giant colossal],
    }
    
    attr_reader :range, :targets, :symbols, :abilities

    
    def initialize(range = 0, targets = 1, symbols = nil)
      @range, @targets = range, targets
      # Creates (default) symbols for a Hero's Base as a hash
      @symbols = symbols || { :speed => 'normal', :attack => 'normal', :defense => 'normal', :damage => 'normal' }
    end
   
    def abilities
      abilities = []
      SYMBOLS.each do |type, name|
        next if name == 'normal'
        # TODO: add giant abilities
        abilites << 'carry' << 'move-and-attack' if name =~ /transport/
        abilites << 'carry' if name =~ /flight/
        # default ability like Flight
        abilities << name.split('-').first
      end
      abilities.compact.map { |name| CombatAbility.get(name) }
    end     
  end
end