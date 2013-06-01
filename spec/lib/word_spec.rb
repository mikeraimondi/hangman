require 'rspec'
require_relative '../../lib/word'

describe Word do
  # As a hangman player
  # I want to be presented with a number of characters representing a random word
  # So that I can guess what that word is
  describe "when blanked out" do

    let(:word) { Word.new }
    # A random word is selected from the dictionary of words
    it "is a word" do
      expect(word.secret).to be_a(String)
    end

    it "is a random word" do
      other_word = Word.new
      expect(word.secret).to_not eql(other_word.secret)
    end

    # The user is presented with a UI that shows 'blanks' for each character of the word
    it "is initially all blanks" do
      blanks = ""
      word.secret.length.times { blanks << "_" }
      expect(word.display).to eql(blanks)
    end

  end

end
