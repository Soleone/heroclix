require File.dirname(__FILE__) + '/test_helper'

class DataCenterTest < Test::Unit::TestCase
  include Heroclix
  
  def setup
  end

  def test_parses_at_least_one_hero
    attributes = DataCenter.parse_all_combat_values
    assert_instance_of Hash, attributes
    assert_equal 1, attributes.keys.size, "should have at least combat values of one hero"
  end
  
  def test_all_heroes
    heroes = DataCenter.all_heroes
    spiderman = heroes.first
    assert_instance_of Hero, spiderman
  end
end