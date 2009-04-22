require File.dirname(__FILE__) + '/test_helper'

class MapTest < Test::Unit::TestCase
  def setup
    @map = Heroclix::Map.load('basic')
  end

  def test_map_has_ten_occupieable_rows
    assert_equal 10, @map.rows.length
  end
  
  def test_map_has_ten_occupieable_columns
    assert_equal 10, @map.columns.length
  end
  
  def test_map_has_squares_loaded_at_correct_positions
    square = @map[1, 1]
    square2 = @map[2, 1]
    square3 = @map[3, 1]
    square4 = @map[4, 1]
    puts square
    puts square2
    puts square3
    puts square4
    assert_equal :clear, square.terrain
  end
  
  def test_get_adjacent_squares
    square = @map[1, 1]
    adjacent = square.adjacent_squares
    puts adjacent
    assert_equal 8, adjacent.size
  end
end