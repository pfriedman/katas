require 'rspec'
require 'prime'
require_relative '../lib/prime_number'
# require File.expand_path(File.join(File.dirname(__FILE__), '../lib/prime_number'))

describe PrimeNumber do
  subject { described_class.new }

  describe '.sieve' do
    it 'returns the 10000 prime numbers' do
      expect(subject.sieve).to eq(Prime.take(10000))
      expect(subject.sieve.count).to eq(10000)
    end
  end

  describe '.first' do
    it 'returns the first n primes' do
      expect(subject.first(255)).to eq(Prime.take(255))
      expect(subject.first(255).count).to eq(255)
    end

    it 'defaults to 100 primes' do
      expect(subject.first).to eq(Prime.take(100))
      expect(subject.first.count).to eq(100)
    end

    it 'raises an ArgumentError for numbers greater than 10000' do
      expect { subject.first(10001) }.to raise_error(ArgumentError)
    end
  end
end