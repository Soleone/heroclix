require File.dirname(__FILE__) + '/test_helper'

class CombatValueTest < Test::Unit::TestCase
  def setup
    @spiderman = Hero.get("Spider-Man")
    @slow = CombatValue.new(:speed, 5, 'lime')
    @fast = CombatValue.new(:speed, 10, nil)
    @fast_and_red = CombatValue.new(:speed, 10, 'red')
  end
  

  def test_should_include_comparable
    assert @spiderman.speed.is_a?(Comparable)
  end
  
  def test_should_be_comparable_by_values_ignoring_color
    assert @fast > @slow
    assert @fast == @fast_and_red
  end
  
  def test_should_print_with_to_string
    assert_equal 9, @spiderman.speed.to_i
    assert_equal 'orange', @spiderman.speed.color
    assert_equal "s9 (orange)", @spiderman.speed.to_s
  end
  
  def test_should_return_colored_if_it_has_any_color
    assert @spiderman.speed.colored?
    assert @spiderman.attack.colored?
    assert @spiderman.defense.colored?
    assert_false @spiderman.damage.colored?
  end
  
  def test_should_return_corresponding_power_if_colored
    assert_equal Power.get(:speed, 'orange'), @spiderman.speed.power
    assert_equal "COMBAT REFLEXES", @spiderman.defense.power.name
  end
  
  def test_should_be_able_to_return_all_existing_colors
    assert_equal 12, CombatValue::COLORS.size
  end
  

end