require 'test/unit'
#require_relative '../lib/i'

class RomanNumberException < StandardError
end

class RomanNumber

  def self.from_number(n, fail=false)
    case n 
        when 0 
            if fail
              raise RomanNumberException 
            else
              ""
            end
        when 1 then "I"
        when 2 then "II"
        when 3 then "III"
        when 4 then "IV"
        when 5 then "V"
        when 6 then "VI"
        when 7 then "VII"
        when 8 then "VIII"
        when 9 then "IX"
        when (10..19) then return "X" + from_number(n%10)
        when (20..29) then return "XX" + from_number(n%10)
        when (30..39) then return "XXX" + from_number(n%10)
        when (40..49) then return "XL" + from_number(n%10)
        when (50..59) then return "L" + from_number(n%10)
        when (60..69) then return "LX" + from_number(n%10)
        when (70..79) then return "LXX" + from_number(n%10)
        when (80..89) then return "LXXX" + from_number(n%10)
        when (90..99) then return "XC" + from_number(n%10)
        when (100..199) then return "C" + from_number(n%100)
        when (200..299) then return "CC" + from_number(n%100)
        when (300..399) then return "CCC" + from_number(n%100)
        when (400..499) then return "CD" + from_number(n%100)
        when (500..599) then return "D" + from_number(n%100)
        when (600..699) then return "DC" + from_number(n%100)
        when (700..799) then return "DCC" + from_number(n%100)
        when (800..899) then return "DCCC" + from_number(n%100)
        when (900..999) then return "CM" + from_number(n%100)
        when (1000..3999) then return 'M'*(n/1000) + from_number(n%1000)
        else raise RomanNumberException
    end  
  end

  def self.to_i(s)
    reg = /I{4,}|V{2,}|X{4,}|L{2,}|C{4,}|D{2,}|M{4,}/i
    raise RomanNumberException.new("Unexpected sequence given #{reg.match s.to_s}") if reg.match s
    a = s.chars.to_a
    process_to_i(a.shift, a)
  end

  private
  def self.process_to_i(c, remaining)
    case c
    when 'I' then process_to_i_from_I(remaining)
    when 'V' then process_to_i_from_V(remaining)
    when 'X' then process_to_i_from_X(remaining)
    when 'L' then process_to_i_from_L(remaining)
    when 'C' then process_to_i_from_C(remaining)
    when 'D' then process_to_i_from_D(remaining)
    when 'M' then process_to_i_from_M(remaining)
    end
  end

  def self.process_to_i_from_I(remaining)
    return 1 if remaining.empty?
    c = remaining.shift
    return 1 + process_to_i(c, remaining) if c == 'I'
    return -1 + process_to_i(c, remaining) if c == 'V' || c == 'X'
    raise RomanNumberException.new "Unexpected character #{c}"
  end

  def self.process_to_i_from_V(remaining)
    return 5 if remaining.empty?
    c = remaining.shift
    return 5 + process_to_i(c, remaining) if c == 'I'
    raise RomanNumberException.new "Unexpected character #{c}"
  end

  def self.process_to_i_from_X(remaining)
    return 10 if remaining.empty?
    c = remaining.shift
    return 10 + process_to_i(c, remaining) if c == 'I' || c == 'V' || c == 'X'
    return -10 + process_to_i(c, remaining) if c == 'L' || c == 'C'
    raise RomanNumberException.new "Unexpected character #{c}"
  end

  def self.process_to_i_from_L(remaining)
    return 50 if remaining.empty?
    c = remaining.shift
    return 50 + process_to_i(c, remaining) if c == 'I' || c == 'V' || c == 'X'
    raise RomanNumberException.new "Unexpected character #{c}"
  end

  def self.process_to_i_from_C(remaining)
    return 100 if remaining.empty?
    c = remaining.shift
    return 100 + process_to_i(c, remaining) if c == 'I' || c == 'V' || c == 'X' || c == 'L' || c == 'C'
    return -100 + process_to_i(c, remaining) if c == 'D' || c == 'M'
    raise RomanNumberException.new "Unexpected character #{c}"
  end

  def self.process_to_i_from_D(remaining)
    return 500 if remaining.empty?
    c = remaining.shift
    return 500 + process_to_i(c, remaining) if c == 'I' || c == 'V' || c == 'X' || c == 'L' || c == 'C'
    raise RomanNumberException.new "Unexpected character #{c}"
  end

  def self.process_to_i_from_M(remaining)
    return 1000 if remaining.empty?
    c = remaining.shift
    return 1000 + process_to_i(c, remaining) if c == 'I' || c == 'V' || c == 'X' || c == 'L' || c == 'C' || c == 'D' || c == 'M'
    raise RomanNumberException.new "Unexpected character #{c}"
  end
end

class Fixnum
  def to_roman
    RomanNumber.from_number(self,true)
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
  def test_40
    assert_equal "XL", 40.to_roman
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
  def test_0_fail
    assert_raise RomanNumberException do
      0.to_roman
    end
  end
  def test_greater_than_3999_fail
    assert_raise RomanNumberException do
      4000.to_roman
    end
  end

  def test_roman_to_i_validates_invalid_sequences
    ["IIII", "VV", "XXXX", "LL", "CCCC", "DD", "MMMM"].each do |x|
      assert_raise RomanNumberException do
        RomanNumber.to_i x
      end
    end
  end

  def test_roman_to_i
    (1..3999).each do |i|
      assert_equal i, RomanNumber.to_i(i.to_roman)
    end
  end
end
