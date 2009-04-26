require File.dirname(__FILE__) + '/test_helper'

class PowerTest < Test::Unit::TestCase
 def setup
    @heroes = Heroclix::Parser.all_heroes
    @spiderman = @heroes.first
  end
  
  def test_should_print_with_to_string
    assert_equal 9, @spiderman.speed.to_i
    assert_equal 'orange', @spiderman.speed.color
    assert_equal "s9 (orange)", @spiderman.speed.to_s
  end
end