require File.dirname(__FILE__) + '/test_helper'

class MapTest < Test::Unit::TestCase
  def setup
    @map = Heroclix::Map.load('basic')
  end

  def test_map_has_ten_occupieable_rows
    assert_equal 10, @map.rows.length
  end
end