require 'spec_helper'

describe TablePrinter do
  let(:table) { MultiplicationTable.new.generate }

  subject { described_class.new(table) }

  describe '.max_cell_width' do
    it 'sets the cell_width for the given table' do
      expect(subject.max_cell_width).to eq(4)
    end
  end

  describe '.print' do
    let(:table) { MultiplicationTable.new.generate(3) }

    let(:output) {
        "    2  3  5 \n" +
        " 2  4  6 10 \n" +
        " 3  6  9 15 \n" +
        " 5 10 15 25 "
    }

    it 'outputs an n x n table prime multiplication table' do
      expect(subject.output).to eq(output)
    end
  end
end