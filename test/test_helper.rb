require 'rubygems'
require 'test/unit'

$LOAD_PATH.unshift(File.dirname(__FILE__))
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
require 'heroclix'

class Test::Unit::TestCase
  include Heroclix
  
  def assert_false(object)
    assert_block("Expected <#{object}> to be false.") { object == false }
  end
  
  
  def assert_terrain_array_equal(sequence, squares)
    assert_square_array_equal(sequence, squares, :terrain)
  end
  
  def assert_wall_array_equal(sequence, squares)
    assert_square_array_equal(sequence, squares, :wall)
  end
  
  # takes a string and an enumerable containing Square instances
  def assert_square_array_equal(sequence, squares, mode = :absolute)
    strip_regexp = case mode
    when :absolute
      /[^#{Heroclix::Square::CHARACTERS.join('')}]/
    when :wall
      /[^.x]/
    when :terrain
      /[x.]/
    end
    
    sequence = sequence.to_s.gsub(strip_regexp, '')
    squares_string = squares.map(&:chr).join('')
    message = "Expected sequence <#{sequence}>, but found <#{squares_string}>"
    assert_block message do
      sequence == squares_string
    end
  end
end
