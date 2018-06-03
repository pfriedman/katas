require 'spec_helper'

describe Cli do

  subject { described_class.new }

  describe '.determine_number_of_primes' do
    context 'default' do
      it 'returns 10' do
        expect(subject.determine_number_of_primes).to eq(10)
      end
    end

    context 'given a string' do
      it 'returns 0' do
        expect(subject.determine_number_of_primes(['hi'])).to eq(0)
      end
    end

    context 'given a number' do
      it 'returns that number' do
        expect(subject.determine_number_of_primes([-123])).to eq(-123)
      end
    end
  end

  describe '.max_number_of_primes_for_screen' do
    before do
      allow(subject).to receive(:window_width).and_return(122)
    end

    it 'returns the max number of primes to output' do
      expect(subject.max_number_of_primes_for_screen(5)).to eq(23)
    end
  end

  describe '.window_width' do
    it 'returns the width of the console' do
      expect(subject.window_width).to be > 0
    end
  end

  describe '.run' do
    context 'given a string' do
      let(:expected) {
        "You asked for a table of 'asdf' elements.\n" +
        "That doesn't really make sense.\n" +
        "Please try again with a different number."
      }
      it 'outputs a warning message' do
        expect(subject).to receive(:output).with(expected)
        subject.run(['asdf'])
      end
    end

    context 'given a very large number' do
      let(:expected) {
        "You asked for a table of '123' elements.\n" +
        "However your screen can only handle up to 16 elements.\n" +
        "Please try again with a number less than or equal to 16."
      }

      before do
        allow(subject).to receive(:max_number_of_primes_for_screen).and_return(16)
      end

      it 'outputs a warning message' do
        expect(subject).to receive(:output).with(expected)
        subject.run([123])
      end
    end
  end
end