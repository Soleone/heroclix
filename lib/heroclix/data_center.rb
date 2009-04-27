require 'iconv'

module Heroclix
  module DataCenter
    POWER_FILES = %w[movpwrs attpwrs defpwrs dampwrs]

    HASH_REGEXP = /::(\w+)\n(.*?)\.\s*$/m
    NAME_REGEXP = /(.+?)( \(OPTIONAL\))?: (.+)/
    COMBAT_VALUES_AND_NAMES_REGEXP = /([^\n]+)\n(([a-z0-9, ]+\n)+)/m

  public

    def self.all_powers
      @powers ||= parse_all_powers
    end
    
    
    def self.all_heroes
      @heroes ||= parse_all_combat_values.map do |name, combat_values|
        Hero.new(name, combat_values)
      end
    end

    # returns a copy of a Hero to be used in a Game
    def self.get_hero(name)
      all_heroes.select { |hero| hero.name == name }.first.dup
    end
  
  private

    def self.parse_powers_file(type, file_content)
      # [[name, value], ...]
      hash = file_content.scan(HASH_REGEXP).inject({}) do |memo, key_value|
        color, value = key_value[0], key_value[1]
        memo[color] = Power.from_array(type, color, value.scan(NAME_REGEXP).flatten)
        memo
      end
    end
   
    # return Hash which maps Hero names to a Hash of CombatValue-Arrays. puh...
    # check this example: "Spider-Man" => {:speed => [CombatValue.new(9, :blue), ...], ...}, ...
    def self.parse_combat_values_file(file_content)
      attributes = {}
      file_content.scan(COMBAT_VALUES_AND_NAMES_REGEXP).each do |name_and_stats|
        # [["Spider-Man", "12 blue, ..."], ...]
        name, stats = name_and_stats[0], name_and_stats[1]
        values = {}
        stats.split("\n").each_with_index do |combat_values, index|
          type = CombatValue::TYPES[index].to_sym
          values[type] = combat_values.split(', ').map do |combat_value|
            CombatValue.from_string(type, combat_value)
          end
        end
        attributes[name] = values
      end
      attributes
    end

    def self.parse_all_powers
      powers = {}
      CombatValue::TYPES.each_with_index do |type, index|
        content = File.read("#{DATA_PATH}/powers/#{POWER_FILES[index]}.txt")
        powers[type] = parse_powers_file(type, content)
      end
      powers
    end

    def self.parse_all_combat_values
      file = "#{DATA_PATH}/combat_values.txt"
      @combat_values ||= parse_combat_values_file(File.read(file))
    end
  end
end