module Heroclix
  class Description
    attr_reader :rank, :edition, :team
    
    def initialize(rank, edition, team)
      @rank, @edition, @team = rank, edition, team
    end
  end
end