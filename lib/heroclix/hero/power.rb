module Heroclix
  class Power
    include Comparable
    
    attr_reader :name, :text, :type, :color

    def self.get(type, color)
      power_by_type_and_color[type.to_sym][color.to_s]
    end

    def self.all
      power_by_type_and_color.values.map{|hash| hash.values}.flatten.sort
    end
        
    def self.from_array(type, color, array)
      name, optional, text = *array
      Power.new(type, color, name, text, {:non_optional => optional.nil?})
    end

    # A Power always has a type (e.g. defense) and color.
    # It is connected to a CombatValue which must be active on a Hero to use
    # this Power.
    def initialize(type, color, name, text, options = nil)
      @type, @color = type, color
      @name, @text = name, text
      @options = options || {:non_optional => false}
    end
    
    def non_optional?
      @options[:non_optional]
    end
    
    def special_name
      @options[:special_name]
    end
    
    def to_s
      full_name = special_name ? "#{special_name} (#{name})" : name 
      "#{full_name}#{' (NON-OPTIONAL)' if non_optional?}: #{text} [#{type} -> #{color}]"
    end
    
    def <=>(other)
      if type != other.type
        CombatValue::TYPES.index(type) <=> CombatValue::TYPES.index(other.type)
      else
        CombatValue::COLORS.index(color) <=> CombatValue::COLORS.index(other.color)
      end
    end
    
  private

    # Returns a hash which maps type => { color => power }
    def self.power_by_type_and_color
      @powers_by_type_and_color ||= DataCenter.all_powers
    end

  end
end