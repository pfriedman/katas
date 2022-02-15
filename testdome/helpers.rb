module Helpers

  # Accepts a hash containing the file owner name for each file name.
  # Returns a hash containing an array of file names for each owner name, in any order.
  # @param[Hash<String, String>] input
  # @return[Hash<String, Array>]
  def self.group_by_owners(input)
    input.each_with_object(Hash.new { |h, k| h[k] = [] }) do |(k, v), result|
      result[v] << k
    end
  end

  # Returns an Array of items in input that match the given filters
  # @param[Array<Hash>] input
  # @param[Lambda, Array<Lambda>] filters
  # @return[Array<Hash>]
  def self.filter(input, filters)
    filters = [filters] unless filters.is_a?(Array)
    filters.compact.each do |f|
      input = input.select { |hsh| f.call(hsh) }
    end
    input
  end

end