class PhraseFetcher
  attr_accessor :text

  UNWANTED_CHARACTERS = /[^a-z0-9\s]/i

  def initialize(text:)
    @text = format(text)
  end

  # Removes all non alphanumeric characters while keeping whitespace
  # @return String
  def format(text)
    text.to_s.downcase.gsub(UNWANTED_CHARACTERS, "")
  end
  private :format

  # All the words in the formatted text split on whitespace
  # @return Array<String>
  def words
    text.split(/\s/).delete_if { |word| word.length.zero? }
  end
end
