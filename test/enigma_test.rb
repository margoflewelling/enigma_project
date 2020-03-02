require_relative 'test_helper'
require './lib/enigma'
require 'mocha/minitest'
require 'date'

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

  def test_it_can_split_message_by_character
    expected = ["h", "e", "l", "l", "o", " ", "w", "o", "r", "l", "d"]
    assert_equal expected, @enigma.split_message("hello world")
    assert_equal ["e", "r", " ", "*", ")"], @enigma.split_message("er *)")
  end

  def test_it_can_encrypt_message
    assert_equal "keder ohulw", @enigma.encrypt_message("hello world", "02715", "040895")
    assert_equal "pysgdmxtlssfdrzh", @enigma.encrypt_message("my name is margo", "02715", "040895")
    assert_equal "py-gdmx-ls:fdrzh", @enigma.encrypt_message("my-name-is:margo", "02715", "040895")
  end

  def test_it_can_decrypt_message
    assert_equal "hello world", @enigma.decrypt_message("keder ohulw", "02715", "040895")
    assert_equal "my name is margo", @enigma.decrypt_message("pysgdmxtlssfdrzh", "02715", "040895")
    assert_equal "my-name-is:margo", @enigma.decrypt_message("py-gdmx-ls:fdrzh", "02715", "040895")
  end

  def test_it_can_decrypt
    expected = {decryption: "hello world", key: "02715", date: "040895"}
    assert_equal expected, @enigma.decrypt("keder ohulw", "02715", "040895")
  end

  def test_it_can_encrypt
    expected = {encryption: "keder ohulw", key: "02715", date: "040895"}
    assert_equal expected, @enigma.encrypt("hello world", "02715", "040895")
  end

  def test_creating_a_random_key
    assert_kind_of String, @enigma.create_random_key
    assert_equal 5, @enigma.create_random_key.length
    @enigma.stubs(:rand).returns(60)
    assert_equal "00060", @enigma.create_random_key
  end

  def test_today
    assert_kind_of String, @enigma.today
    assert_equal 6, @enigma.today.length
    Date.stubs(:today).returns(Date.new(2019, 4, 27))
    assert_equal "042719", @enigma.today
  end

  def test_it_can_encrypt_without_key_or_date
    expected = {:encryption=>"gsdsnnovqzw", :key=>"53734", :date=>"022520"}
    @enigma.stubs(:create_random_key).returns("53734")
    @enigma.stubs(:today).returns("022520")
    assert_equal expected, @enigma.encrypt("hello world")
  end

  def test_it_can_decrypt_without_date
    expected = {:decryption=>"hello world", :key=>"53734", :date=>"022520"}
    @enigma.stubs(:today).returns("022520")
    assert_equal expected, @enigma.decrypt("gsdsnnovqzw", "53734")
  end

end
