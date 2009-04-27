module Heroclix
  class Description
    attr_reader :rank, :edition, :team, :keywords
    
    def initialize(rank, edition, team, keywords = [])
      @rank, @edition, @team = rank, edition
      @team, @keywords = team, keywords
    end
  end
end