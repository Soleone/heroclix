require 'iconv'

module Heroclix
  module Parser
    HASH_REGEXP = /::(\w+)\n(.*?)\.\s*\n/m
    NAME_REGEXP = /(.+?)( \(OPTIONAL\))?: (.+)/
    
    COMBAT_VALUES_AND_NAMES_REGEXP = /([^\n]+)\n(([a-z0-9, ]+\n)+)/m
    
    POWER_FILES = %w[movpwrs attpwrs defpwrs dampwrs]
    POWER_NAMES = %w[speed attack defense damage]
  
    def self.parse_powers_file(file_content)
      # [[name, value], ...]
      hash = file_content.scan(HASH_REGEXP).inject({}) do |memo, key_value|
        key, value = key_value[0], key_value[1]
        memo[key] = Power.from_array(value.scan(NAME_REGEXP).flatten)
        memo
      end
    end
   
    def self.parse_combat_values_file(file_content)
      # [["Spider-Man", "12 blue, ..."], ...]
      attributes = {}
      file_content.scan(COMBAT_VALUES_AND_NAMES_REGEXP).each do |name_and_stats|
        name, stats = name_and_stats[0], name_and_stats[1]
        values = {}
        stats.split("\n").each_with_index do |combat_values, index|
          values[POWER_NAMES[index].to_sym] = combat_values.split(', ').map do |combat_value|
            CombatValue.from_string(combat_value)
          end
        end
        attributes[name] = values
      end
      attributes
    end
    
    def self.parse_all_powers
      powers = {}
      POWER_NAMES.each_with_index do |power, index|
        content = File.read("#{DATA_PATH}/powers/#{POWER_FILES[index]}.txt")
        powers[power] = Parser.parse_powers_file(content)
      end
      powers
    end
    
    def self.all_powers
      @powers ||= parse_all_powers
    end
    
    def self.parse_all_combat_values
      file = "#{DATA_PATH}/combat_values.txt"
      @combat_values ||= parse_combat_values_file(File.read(file))
    end
    
    def self.all_heroes
      @heroes ||= parse_all_combat_values.map do |name, combat_values|
        Hero.new(name, combat_values)
      end
    end
  end
end