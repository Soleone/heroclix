require File.dirname(__FILE__) + '/test_helper'

class TestParser < Test::Unit::TestCase
  def setup
  end

  def test_parses_at_least_one_hero
    attributes = Heroclix::Parser.parse_all_combat_values
    assert_instance_of Hash, attributes
    assert_equal 1, attributes.keys.size, "should have at least combat values of one hero"
  end
  
  def test_all_heroes
    heroes = Heroclix::Parser.all_heroes
    spiderman = heroes.first
    assert_instance_of Heroclix::Hero, spiderman
  end
end