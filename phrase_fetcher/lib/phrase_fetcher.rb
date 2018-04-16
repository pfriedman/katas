class PhraseFetcher
  attr_accessor :text, :sequence_length, :limit, :word_sequences

  UNWANTED_CHARACTERS = /[^a-z0-9\s]/i

  # @param [String] text The text for mining
  # @param [Integer] sequence_length The length of the word sequence to grab
  # @param [Integer] limit The number of words sequence to return
  def initialize(text:, sequence_length: 3, limit: 100)
    @text = format(text)
    @sequence_length = sequence_length
    @limit = limit
    @word_sequences = Hash.new { |hsh, sequence| hsh[sequence] = 0 }
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
    @words ||= text.split(/\s/).delete_if { |word| word.length.zero? }
  end

  # Determine how often the sequence_length of words occurs in the given text
  # sorted from most often encountered to least
  # @return [Array<Array<Integer, String>>]
  def most_common_word_sequences
    count_sequence_occurrences
    most_common
  end

  def count_sequence_occurrences
    idx = 0
    while (words.length - sequence_length) >= idx
      sequence = words[idx, sequence_length].join(" ")
      word_sequences[sequence] += 1
      idx += 1
    end
  end
  private :count_sequence_occurrences

  # @return [Array<Array<Integer, String>>]
  def most_common
    word_sequences.sort_by { |_key, value| value }.reverse[0, limit]
  end
  private :most_common
end
