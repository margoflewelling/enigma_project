require_relative 'test_helper'
require './lib/enigma'
require 'mocha/minitest'

class EnigmaTest < Minitest::Test

  def setup
    @enigma = Enigma.new
  end

  def test_it_exists
    assert_instance_of Enigma, @enigma
  end

  def test_it_can_create_alphabet
    expected = ["a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k",
                "l", "m", "n", "o", "p", "q", "r", "s", "t", "u", "v",
                "w", "x", "y", "z", " "
                ]
    assert_equal expected, @enigma.alphabet
  end

  def test_it_can_create_the_keys
    expected = {"A"=>"02", "B"=>"27", "C"=>"71", "D"=>"15"}
    assert_equal expected, @enigma.create_keys("02715")
  end

  def test_it_can_create_the_offset
    expected = {"A"=>"1", "B"=>"0", "C"=>"2", "D"=>"5"}
    assert_equal expected, @enigma.create_offsets("040895")
  end

  def test_creating_final_shift
    expected = {"A"=>3, "B"=>27, "C"=>73, "D"=>20}
    assert_equal expected, @enigma.final_shift("02715", "040895")
  end

end
