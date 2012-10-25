require 'test/unit'
#require_relative '../lib/i'

class I
end

class II
end

class Fixnum
  def to_roman
    "I"
  end
end

class RomanTest < Test::Unit::TestCase
  def test_1
    assert_equal "I", 1.to_roman
  end
  def test_2
    assert_equal "II", 2.to_roman
  end
  def test_3
    assert_equal "III", 3.to_roman
  end
  def test_4
    assert_equal "IV", 4.to_roman
  end
  def test_5
    assert_equal "V", 5.to_roman
  end
  def test_6
    assert_equal "VI", 6.to_roman
  end
  def test_7
    assert_equal "VII", 7.to_roman
  end
  def test_8
    assert_equal "VIII", 8.to_roman
  end
  def test_9
    assert_equal "IX", 9.to_roman
  end
  def test_10
    assert_equal "X", 10.to_roman
  end
  def test_50
    assert_equal "L", 50.to_roman
  end
  def test_100
    assert_equal "C", 100.to_roman
  end
  def test_500
    assert_equal "D", 500.to_roman
  end
  def test_1000
    assert_equal "M", 1000.to_roman
  end
end