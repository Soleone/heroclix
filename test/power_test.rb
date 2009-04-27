require File.dirname(__FILE__) + '/test_helper'

class PowerTest < Test::Unit::TestCase
  
 def setup
    @spiderman = Heroclix::DataCenter.get_hero("Spider-Man")
    @unsorted_powers = [Power.get(:speed, 'orange'), Power.get(:defense, 'lime'), Power.get(:attack, 'lime'), Power.get(:speed, 'lime')]
    @flurry = Power.get(:speed, 'red')
  end
  
  
  def test_should_include_comparable
    assert @flurry.is_a?(Comparable)
  end

  def test_should_print_with_to_string
    assert_equal 9, @spiderman.speed.to_i
    assert_equal 'orange', @spiderman.speed.color
    assert_equal "s9 (orange)", @spiderman.speed.to_s
  end
  
  def test_should_always_be_sorted_by_speed_first
    sorted_powers = @unsorted_powers.sort
    assert_equal [:speed, :speed, :attack, :defense], sorted_powers.map{|p| p.type}
    assert_equal 'lime', sorted_powers.first.color
  end
end