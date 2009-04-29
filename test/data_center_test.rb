require File.dirname(__FILE__) + '/test_helper'

class DataCenterTest < Test::Unit::TestCase
  def setup
  end

  def test_parses_at_least_one_hero
    attributes = DataCenter.parse_all_combat_values
    assert_instance_of Hash, attributes
    assert attributes.keys.size > 1, "should have at least combat values of two heroes"
  end
  
  def test_all_heroes
    heroes = DataCenter.all_heroes
    spiderman = heroes.first
    assert_instance_of Hero, spiderman
    torch = heroes[1]
    assert_instance_of Hero, torch
    assert_equal 7, torch.max_health
  end
end