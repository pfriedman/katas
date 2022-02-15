require File.expand_path(File.join(File.dirname(__FILE__), "helpers"))

describe Helpers do

  describe '.group_by_owners' do
    let(:input) { {'Input.txt' => 'Randy', 'Code.py' => 'Stan', 'Output.txt' => 'Randy'} }
    let(:expected) { {'Randy' => ['Input.txt', 'Output.txt'], 'Stan' => ['Code.py']} }

    subject { described_class.group_by_owners(input) }

    it { is_expected.to eq(expected) }
  end

  describe '.filter' do
    let(:input) {
      [
        { name: 'Thomas Edison', gpa: 3.45 },
        { name: 'Grace Hopper', gpa: 3.99 },
        { name: 'Leonardo DaVinci', gpa: 2.78 }
      ]
    }
    let(:filters) { nil }

    subject { described_class.filter(input, filters) }

    context 'when not given any lambda' do
      it 'returns the given input' do
        expect(subject).to eq input
      end
    end

    context 'when given one filter' do
      let(:filters) { ->(record) { record[:gpa] > 3.0 } }
      let(:expected) {
        [{ name: 'Thomas Edison', gpa: 3.45 }, { name: 'Grace Hopper', gpa: 3.99 }]
      }

      it 'returns the values matching the filter' do
        expect(subject).to eq expected
      end
    end

    context 'when given multiple filter' do
      let(:filters) { [->(record) { record[:gpa] > 3.0 }, ->(record) { record[:name].include?('Grace') }] }
      let(:expected) {
        [{ name: 'Grace Hopper', gpa: 3.99 }]
      }

      it 'returns the values matching the filters' do
        expect(subject).to eq expected
      end
    end

  end

end
