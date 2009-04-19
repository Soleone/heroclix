require File.dirname(__FILE__) + '/test_helper'

class TestHero < Test::Unit::TestCase
  def setup
    @heroes = Heroclix::Parser.all_heroes
    @spiderman = @heroes.first
    @spiderman.heal! 10
  end

  def test_hero_has_name
    assert @spiderman
    assert_equal "Spider-Man", @spiderman.name
  end
  
  def test_hero_has_starting_combat_values
    assert_equal 6, @spiderman.speed.to_i
    assert_equal 12, @spiderman.attack.to_i
    assert_equal 17, @spiderman.defense.to_i
    assert_equal 2, @spiderman.damage.to_i
  end
  
  def test_hero_has_correct_combat_values_at_four_damage
    @spiderman.damage! 4
    assert_equal 4, @spiderman.clicks
    assert_equal 4, @spiderman.speed.to_i
    assert_equal 11, @spiderman.attack.to_i
    assert_equal 19, @spiderman.defense.to_i
    assert_equal 1, @spiderman.damage.to_i
  end
end