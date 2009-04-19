module Heroclix
  class Power
    attr_reader :name, :text

    def self.from_array(array)
      name, optional, text = array[0], array[1], array[2]
      Power.new(name, text, optional.nil?)
    end

    
    def initialize(name, text, non_optional=false)
      @name, @text, @non_optional = name, text, non_optional
    end
    
    def non_optional?
      @non_optional
    end
    
    def to_s
      "#{name}#{' (NON-OPTIONAL)' if non_optional?}: #{text}"
    end
  end
end