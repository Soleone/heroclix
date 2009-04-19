module Heroclix
  class Map
    def self.load(map_file)
      Map.new(File.readlines(DATA_PATH + "/maps/#{map_file}.txt"))
    end
    
    def initialize(list_of_lines)
      @rows = []
      list_of_lines.each do |line|
        next if line.size < 5 # arbitrary limit. enough to not represent a new line
        @rows << line.scan(/./).map do |character|
          Square.parse(character)
        end
      end
    end

    # only rows players can enter, e.g. no walls
    def rows
      rows = []
      0.step(@rows.size, 2) do |row_no|
        rows << @rows[row_no]
      end
      rows
    end
  end
end