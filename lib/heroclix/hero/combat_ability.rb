module Heroclix

  # Basic abilities for Heroes speed, attack, defense and damage 
  # (e.g. Flying or Sharpshooter)
  
  class CombatAbility
    attr_reader :name, :text
    
    def all
      # TODO: initialize all abilities from Parser or somewhere
      @all_combat_abilities ||= []      
    end
    
    def self.get(name)
      all.select{|ability| ability.name == name}.first
    end
      
    def initialize(name, text = nil)
      # TODO: maybe abstract validation somewhere in a small DSL (too much code here)
      unless (all = ALL.values.flatten).include?(name)
        raise ArgumentError("Invalid name: #{name}. Must be one of #{all.unique.join(', ')}.")
      end
      @name, @text = name, text
    end

    
  end
end