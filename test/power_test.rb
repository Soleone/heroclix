require File.dirname(__FILE__) + '/test_helper'

class PowerTest < Test::Unit::TestCase
  
 def setup
    @spiderman = Hero.get("Spider-Man")
    @unsorted_powers = [Power.get(:speed, 'lime'), Power.get(:defense, 'lime'), Power.get(:attack, 'lime'), Power.get(:speed, 'orange')]
    @flurry = Power.get(:speed, 'red')
  end
  
  
  def test_should_include_comparable
    assert @flurry.is_a?(Comparable)
  end

  def test_should_show_its_properties_with_to_s
    assert_equal 9, @spiderman.speed.to_i
    assert_equal 'orange', @spiderman.speed.color
    assert_equal "s9 (orange)", @spiderman.speed.to_s
  end
  
  def test_should_always_be_sorted_by_speed_first_and_then_by_color
    sorted_powers = @unsorted_powers.sort
    assert_equal [:speed, :speed, :attack, :defense], sorted_powers.map{|p| p.type}
    assert_equal 'orange', sorted_powers.first.color
  end
  
  def test_should_detect_if_power_is_non_optional
    toughness = Power.get(:defense, 'orange')
    defense = Power.get(:defense, 'yellow')
    assert toughness.non_optional?
    assert_false defense.non_optional?
  end
end