require 'test/unit'
require_relative '../lib/reader'

class ReaderTest < Test::Unit::TestCase
  def setup
    @reader = Reader.new(File.expand_path('../fixtures/entries_0_9.txt', __FILE__))
  end

  def test_initialize_should_raise_an_exception_if_file_does_not_exist
    assert_raise ReaderException do
      Reader.new('/tmp/pepe')
    end
  end

  def test_valid
    Dir[File.expand_path('../fixtures/entries_invalid*', __FILE__)].each do |file|
      reader = Reader.new(file)
      assert !reader.valid?
    end

    assert @reader.valid?
  end

  def test_empty_file_should_return_an_empty_array
    reader = Reader.new(File.expand_path('../fixtures/entries_empty.txt', __FILE__))
    assert reader.ocr.empty?
  end

  def test_a_file_with_40_lines_should_return_an_array_of_size_10
    assert_equal 10, @reader.ocr.size
  end

  def test_ocr_should_return_an_array
    assert_equal Array, @reader.ocr.class
  end
end

