module Heroclix
  class Power
    attr_reader :name, :text, :type, :color

    def self.get(type, color)
      DataCenter.all_powers[type.to_sym][color.to_s]
    end
    
    def self.from_array(type, color, array)
      name, optional, text = *array
      Power.new(type, color, name, text, optional.nil?)
    end

    
    def initialize(type, color, name, text, non_optional=false)
      @type, @color = type, color
      @name, @text, @non_optional = name, text, non_optional
    end
    
    def non_optional?
      @non_optional
    end
    
    def to_s
      "#{name}#{' (NON-OPTIONAL)' if non_optional?}: #{text} [#{type} -> #{color}]"
    end
  end
end