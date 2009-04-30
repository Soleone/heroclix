require 'iconv'

module Heroclix
  module Parser
    POWER_FILES = %w[movpwrs attpwrs defpwrs dampwrs]

    HASH_REGEXP = /::(\w+)\n(.*?)\.\s*$/m
    NAME_REGEXP = /(.+?)( \(OPTIONAL\))?: (.+)/
    # looks like: name \n combatvalues{4} \n combatsymbols
    HEROES_REGEXP = /(.+?)\n\n+/m


  public

    def self.all_powers
      powers = {}
      CombatValue::TYPES.each_with_index do |type, index|
        content = File.read("#{DATA_PATH}/powers/#{POWER_FILES[index]}.txt")
        powers[type] = parse_powers_file(type, content)
      end
      powers
    end
    
    def self.all_heroes
      file = "#{DATA_PATH}/heroes.txt"
      parse_heroes_file(File.read(file))
    end

  private

    def self.parse_powers_file(type, file_content)
      # [[name, value], ...]
      hash = file_content.scan(HASH_REGEXP).inject({}) do |memo, key_value|
        color, value = key_value
        memo[color] = Power.from_array(type, color, value.scan(NAME_REGEXP).flatten)
        memo
      end
    end
   
    # return Hash which maps Hero names to a Hash of CombatValue-Arrays. puh...
    # check this example: "Spider-Man" => {:speed => [CombatValue.new(9, :blue), ...], ...}, ...
    def self.parse_heroes_file(file_content)
      # TODO: return Heroes here directly instead of only the combat values
      heroes = []
      file_content.split("\n\n").each do |name_stats_and_abilities|
        # [["Spider-Man", "12 blue, ...", "flight, sharpshooter"], ...]
        hero_array = name_stats_and_abilities.split("\n")
        name, stats, combat_symbols = hero_array[0], hero_array[1..4], hero_array[5]
        values = {}
        stats.each_with_index do |combat_values, index|
          type = CombatValue::TYPES[index].to_sym
          values[type] = combat_values.split(', ').map do |combat_value|
            CombatValue.from_string(type, combat_value)
          end
        end
        heroes << Hero.new(name, values, parse_base(combat_symbols))
      end
      heroes
    end

    def self.parse_base(combat_symbols)
      symbols = {}
      range, range_targets = 0, 1

      combat_symbols.split(', ').each do |symbol|
        name, value = symbol.split(' ')
        if value
          name == 'range' ? range = value.to_i : range_targets = value.to_i
        else
          symbols[Base.type_for_combat_symbol(name)] = name         
        end
      end
      Base.new(range, range_targets, symbols)
    end
  end
end