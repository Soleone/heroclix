module Heroclix
  # Card holding special abilities and other metadata about the Hero
  class Card
    attr_reader :rank, :edition, :team, :keywords
    
    def initialize(rank, edition, team, keywords = [])
      @rank, @edition, @team = rank, edition
      @team, @keywords = team, keywords
    end
  end
end