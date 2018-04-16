require File.expand_path(File.join(File.dirname(__FILE__), "../lib/phrase_fetcher"))

describe PhraseFetcher do
  subject { described_class.new(text: text) }

  let(:text) { "text" }

  describe ".new" do
    it "creates a new PhraseFetcher instance" do
      expect(subject).not_to be_nil
    end
  end

  describe "#text" do
    it "sets the text" do
      expect(subject.text).to eq text
    end

    context "given mixed case characters" do
      let(:text) { "TeXt" }

      it "downcases the text" do
        expect(subject.text).to eq "text"
      end
    end

    context "given non alphanumeric characters" do
      let(:text) { "te)xt<>123';ert*" }

      it "contains only alphanumeric characters" do
        expect(subject.text).to eq "text123ert"
      end
    end
  end

  describe "#words" do
    let(:text) {
      %Q(
        She said,
        "I know what it's like to be dead
         I know what it is to be sad".
        And she's making me feel like I've never been born.
      )
    }

    let(:expected) {
      %w[
        she said
        i know what its like to be dead
        i know what it is to be sad
        and shes making me feel like ive never been born
      ]
    }

    it "collects all the words in the given text" do
      expect(subject.words).to eq expected
    end
  end

  describe "#most_common_word_sequences" do
    let(:text) {
      text = ""
      text << "I'm the winner " * 8
      text << "The runner up " * 6
      text << "Third place result " * 4
      text << "Three other words"
      text
    }

    let(:expected) {
      [
        ["im the winner", 8],
        ["winner im the", 7],
        ["the winner im", 7],
        ["the runner up", 6],
        ["runner up the", 5],
        ["up the runner", 5],
        ["third place result", 4],
        ["result third place", 3],
        ["place result third", 3],
        ["runner up third", 1],
        ["up third place", 1],
        ["winner the runner", 1],
        ["the winner the", 1],
        ["place result three", 1],
        ["result three other", 1],
        ["three other words", 1]
      ]
    }

    it "returns the most common word sequences" do
      expect(subject.most_common_word_sequences).to eq expected
    end
  end
end
