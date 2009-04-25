require File.dirname(__FILE__) + '/test_helper'

class MapTest < Test::Unit::TestCase
  def setup
    @map = Heroclix::Map.load('basic')
  end

  def test_should_have_have_ten_occupieable_rows
    assert_equal 10, @map.relative_rows.length
  end
  
  def test_should_have_ten_occupieable_columns
    assert_equal 10, @map.relative_columns.length
  end

  def test_should_return_array_of_positions_at_arbitrary_absolute_row
    first_row = @map.rows.first
    assert_equal 21, first_row.size
    
    assert_square_array_equal "....x...........x....", first_row
    assert_square_array_equal "..xxxxxxxxxxx........", @map.rows.last
  end
  
  def test_should_return_array_of_positions_at_arbitrary_terrain_row
    first_row = @map.relative_rows.first
    assert_equal 10, first_row.size
    
    assert_terrain_array_equal ".o.oxo.o.o.o.o.oxo.o.", first_row
    assert_terrain_array_equal ".oxo.o.o.o.oxo.o.o.o.", @map.relative_rows.last
  end
  
  def test_should_return_array_of_positions_at_arbitrary_terrain_column
    first_column = @map.relative_columns.first
    assert_equal 10, first_column.size
    
    assert_terrain_array_equal 'o'*10, first_column
    assert_terrain_array_equal "ooooo++o+o", @map.relative_columns[2]
  end
  
end