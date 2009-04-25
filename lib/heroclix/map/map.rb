module Heroclix
  class Map
    attr_reader :name
    
    def self.load(map_file)
      Map.new(map_file.capitalize, File.readlines(DATA_PATH + "/maps/#{map_file}.txt"))
    end
    
    
    def initialize(name, list_of_lines)
      @name = name
  
      # number of characters in first line of file defines width of map
      @total_width = list_of_lines.first.chomp.size
      @total_height = list_of_lines.size

      @width  = @total_width / 2
      @height = @total_height / 2

      @all_rows = []
      list_of_lines.each_with_index do |line, y|
        @all_rows[y] = []
        line.chomp.split(//).each_with_index do |square, x|
          @all_rows[y] << Square.parse(square, self, x, y)
        end
      end
    end

    # only rows a Hero can enter, e.g. no walls
    def rows
      @all_rows
    end
    
     # only columns a Hero can enter, e.g. no walls
    def columns
      # TODO: transpose possibly doesn't work for rectangular (non-square) maps
      @all_columns ||= rows.transpose
    end
    
    
    # set terrain to false to return wall rows
    def relative_rows(square_type = :terrain)
      @rows ||= {}
      return @rows[square_type] if @rows[square_type] 
      
      @rows[square_type] = @all_rows.values_at(*relative_indexes(:rows, square_type)).map do |column|
        column.values_at(*relative_indexes(:columns, square_type))
      end
    end
    
    def relative_columns(square_type = :terrain)
      @columns ||= relative_rows(square_type).transpose  
    end
    
    # square_type can be :absolute, :terrain or :border
    def get(x, y, mode = :absolute)
      case mode.to_sym
      when :absolute
        @all_rows[y][x]
      else 
        relative_rows(mode)[y][x]
      end
    end
    
    # get (terrain) square at x and y position (starts with 1, not 0!)
    # use this as high level interface
    def [](x, y)
      return nil if x < 1 || x > @width || y < 1 || y > @height
      
      square = get(x-1, y-1, :terrain)
    end
   
     
  private
        
    def relative_indexes(rows_or_columns = :rows, square_type = :terrain)
      @indexes ||= {}
      @indexes[rows_or_columns] ||= {}
      
      return @indexes[rows_or_columns][square_type] if @indexes[rows_or_columns][square_type]

      size = rows_or_columns.to_sym == :rows ? @height : @width
      indexes = Array.new(size) do |i|
        i * 2 + (square_type.to_sym == :terrain ? 1 : 0)
      end
      @indexes[rows_or_columns][square_type] = indexes
    end

  
  end
end