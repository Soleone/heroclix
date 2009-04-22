module Heroclix
  class Map
    attr_reader :name
    
    def self.load(map_file)
      Map.new(map_file.capitalize, File.readlines(DATA_PATH + "/maps/#{map_file}.txt"))
    end
    
    
    def initialize(name, list_of_lines)
      @name = name

      @total_width = list_of_lines.first.chomp.size
      @total_height = list_of_lines.size
      @width  = @total_width / 2
      @height = @total_height / 2

      @all_rows = Array.new(@total_height, [])

      # even - walls
      @wall_x_positions    ||= Array.new(@width)  { |i| i * 2 }
      @wall_y_positions    ||= Array.new(@height) { |i| i * 2 }

      # odd - can by occupied
      @terrain_x_positions ||= Array.new(@width)  { |i| i * 2 + 1 }
      @terrain_y_positions ||= Array.new(@height) { |i| i * 2 + 1 }
      
      (0...@total_height).each do |y|
        line = list_of_lines[y]
        (0...@total_width).each do |x|
          @all_rows[y] << Square.parse(line[x, 1], Position.new(self, x, y))
        end
      end

    end

    # only rows a Hero can enter, e.g. no walls
    def rows
      @rows ||= @all_rows.values_at(*@terrain_y_positions).map do |row|
        row.values_at(*@terrain_x_positions)
      end
    end
    
     # only columns a Hero can enter, e.g. no walls
    def columns
      # TODO: transpose possibly doesn't work for rectangular (non-square) maps
      @columns ||= rows.transpose
    end
    
    # get square at x and y position (starts with 1, not 0!)
    def [](x, y)
      return nil if x < 1 || x > @width || y < 1 || y > @height
      rows[y-1][x-1]
    end
  end
end