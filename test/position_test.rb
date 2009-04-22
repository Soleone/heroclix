require File.dirname(__FILE__) + '/test_helper'

class PositionTest < Test::Unit::TestCase
  def setup
    @map = Heroclix::Map.load('basic')
  end

  def test_get_absolute
    square = @map.get(4,1, :absolute)
    assert_equal [4,1], square.position.to_a
    assert_equal :wall, square.terrain
    
    square = @map.get(19,7, :absolute)
    assert_equal [19,7], square.position.to_a
    assert_equal :blocking, square.terrain
  end

  def test_get_wall
    square = @map.get(4,2, :wall)
    assert_equal [8,4], square.position.to_a
    assert_equal [4,2], square.position.relative(:wall).to_a
    assert_equal :wall, square.terrain
  end

  def test_get_terrain
    square = @map.get(1,1, :terrain)
    assert_equal [3,3], square.position.to_a
    assert_equal [1,1], square.position.relative.to_a

    square = @map.get(2,5, :terrain)
    assert_equal [5,11], square.position.to_a
    assert_equal [2,5], square.position.relative.to_a
    assert_equal :hindering, square.terrain
  end
  
  def test_map_has_squares_loaded_at_correct_positions
    square = @map[1,1] 
    square2 = @map[2,1]
    square3 = @map[3,1]
    square4 = @map[4,1]
    assert_equal :clear, square.terrain
  end
  
  def test_get_adjacent_squares
    square = @map[1, 1]
    adjacent = square.adjacent_squares
    assert_equal 8, adjacent.size
  end
end