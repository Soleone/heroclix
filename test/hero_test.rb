require File.dirname(__FILE__) + '/test_helper'

class HeroTest < Test::Unit::TestCase
  include Heroclix
  
  def setup
    @spiderman = Heroclix::DataCenter.get_hero("Spider-Man")
    @start_powers = [Power.get(:speed, 'orange'), Power.get(:attack, 'lime'),Power.get(:defense, 'lime')]
    @later_powers = [Power.get(:speed, 'red'),    Power.get(:attack, 'red'), Power.get(:defense, 'red') ]
  end

  def test_should_have_name
    assert @spiderman
    assert_equal "Spider-Man", @spiderman.name
  end
  
    def test_should_have_speed_attack_defense_and_damage
    assert_instance_of CombatValue, @spiderman.speed
    assert_instance_of CombatValue, @spiderman.attack
    assert_instance_of CombatValue, @spiderman.defense
    assert_instance_of CombatValue, @spiderman.damage
  end
  
  def test_should_have_starting_combat_values
    assert_equal 9, @spiderman.speed.to_i
    assert_equal 12, @spiderman.attack.to_i
    assert_equal 17, @spiderman.defense.to_i
    assert_equal 2, @spiderman.damage.to_i
  end
  
  def test_should_have_correct_combat_values_at_four_damage
    @spiderman.damage! 4
    assert_equal 4, @spiderman.clicks
    assert_equal 7, @spiderman.speed.to_i
    assert_equal 11, @spiderman.attack.to_i
    assert_equal 19, @spiderman.defense.to_i
    assert_equal 1, @spiderman.damage.to_i
  end
  
  def should_have_computed_maximum_health
    assert_equal 5, @spiderman.max_health
  end
  
  def test_should_have_correct_health_for_damage
    @spiderman.damage! 4
    assert_equal 1, @spiderman.health
  end
  
  def test_should_show_active_powers_for_current_clicks
    assert_equal @start_powers, @spiderman.active_powers
    @spiderman.damage! 1
    assert_equal [], @spiderman.active_powers
    @spiderman.damage! 2
    assert_equal @later_powers, @spiderman.active_powers
  end
  
  def test_should_be_able_to_show_all_powers
    all_powers = @start_powers + @later_powers
    assert_equal all_powers.to_set, @spiderman.all_powers
  end
end