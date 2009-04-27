require File.dirname(__FILE__) + '/test_helper'

class PlayerTest < Test::Unit::TestCase
  def setup
    @map = Heroclix::Map.load('basic')
    @player = Player.new("Soleone", 200)
  end

  def test_player_should_have_name
    assert_equal "Soleone", @player.name
  end
  
  def test_player_should_have_points
    assert_equal 200, @player.points
  end
  
  def test_player_should_have_heroes_in_array
    assert_instance_of Array, @player.heroes
  end
end