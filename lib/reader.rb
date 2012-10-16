class ReaderException < StandardError
end

class Reader
  attr_reader :filename

  def initialize(filename)
    @filename = filename
    raise ReaderException.new(filename) unless File.exists?(@filename)
  end

  def valid?
    file = File.new filename

    no = 1
    file.each do |line|
      line.chomp!
      return false if line.size != 27
      if no % 4 != 0
        return false unless /^[_ |]+$/ =~ line
      else
        return false unless /^[ ]+$/ =~ line
      end
      no += 1
    end
    return false unless (no - 1) % 4 == 0
    true
  end

  def ocr
    file = File.new filename
    []
  end
end

