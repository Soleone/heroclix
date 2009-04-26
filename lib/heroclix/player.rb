module Heroclix
  class Player
    attr_reader :name, :points, :heroes
    
    def initialize(name, points, heroes = [])
      @name, @points, @heroes = name, points, heroes
      @heroes = heroes
    end
  end
end