require_relative 'prime_number'

class MultiplicationTable

  attr_reader :prime_number

  def initialize
    @prime_number = PrimeNumber.new
  end

  def generate(n = 10)
    primes = prime_number.first(n)
    create_table(primes)
  end

  def create_table(primes)
    table = []
    table << primes
    primes.each do |prime1|
      table << new_row(prime1, primes)
    end
    table
  end
  private :create_table

  def new_row(number, primes)
    result = []
    result << number
    primes.each do |prime|
      result << number * prime
    end
    result
  end
  private :new_row
end