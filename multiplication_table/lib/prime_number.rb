class PrimeNumber

  attr_reader :numbers, :max

  def initialize
    ten_thousandth_prime = 104729
    @max = ten_thousandth_prime + 1
    @numbers = (0..@max).to_a
    @primes = sieve
  end

  # @return [Array<Integer>] The first n prime numbers
  def first(n = 100)
    raise ArgumentError if n > 10000
    @primes[0, n]
  end

  # @return [Array<Integer>] The first 10000 prime numbers
  def sieve
    numbers[0] = nil
    numbers[1] = nil

    numbers.each do |num|
      next unless num
      break if square(num) > max
      nullify_non_primes(num)
    end
    numbers.compact
  end

  def nullify_non_primes(num)
    square(num).step(max, num) { |index| numbers[index] = nil }
  end
  private :nullify_non_primes

  def square(num)
    num * num
  end
  private :square

end