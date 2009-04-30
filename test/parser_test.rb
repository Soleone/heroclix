require File.dirname(__FILE__) + '/test_helper'

class ParserTest < Test::Unit::TestCase
  def setup
    @heroes = Parser.all_heroes
  end

  def test_parses_at_least_one_hero
    assert_instance_of Array, @heroes
    assert @heroes.size >= 3, "should have at least combat values of three heroes"
  end
  
  def test_all_heroes
    spiderman = @heroes.first
    assert_instance_of Hero, spiderman
    
    torch = @heroes[1]
    assert_instance_of Hero, torch
    assert_equal 7, torch.max_health
    
    electro = @heroes[2]
    assert_equal 8, electro.range

  end
end