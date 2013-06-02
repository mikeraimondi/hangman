require 'rspec'
require_relative '../../lib/word'

describe Word do

  let(:word) { Word.new }
  # As a hangman player
  # I want to be presented with a number of characters representing a random word
  # So that I can guess what that word is
  describe "when blanked out" do

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

  # As a hangman player
  # I want to guess a letter
  # So that I can get closer to guessing the word
  describe "when guessing a letter" do
    before(:each) { word.test_override "OREO" }

    # If I guess a letter that is contained in the word, all occurrences of the letter is filled in
    it "fills in all occurrences of the guessed letter" do
      word.guess "o"
      expect(word.display).to eql("O__O")
    end

    # If I guess a letter that is not contained in the word, I am told that the letter is not found in the word
    it "returns a message that the letter is not found if the guess is wrong" do
      result = word.guess "q"
      expect(result[:message]).to eql("Sorry, we did not find Q!")
    end

    # If I guess a letter that has already been guessed, I am told it has already been guessed and that I must enter a new letter
    it "returns a message that the letter has already been guessed if a successful guess is duplicated" do
      word.guess "r"
      result = word.guess "r"
      expect(result[:message]).to eql("R has already been played, silly!")
    end

    it "returns a message that the letter has already been guessed if an unsuccessful guess is duplicated" do
      word.guess "f"
      result = word.guess "f"
      expect(result[:message]).to eql("F has already been played, silly!")
    end

    # It should be case insensitive, meaning there should be no difference in behavior if I specify an 'A' or an 'a'
    it "is case insensitive" do
      word.guess "O"
      expect(word.display).to eql("O__O")
      result = word.guess "Q"
      expect(result[:message]).to eql("Sorry, we did not find Q!")
      word.guess "R"
      result = word.guess "R"
      expect(result[:message]).to eql("R has already been played, silly!")
    end

    it "raises an error if the input is invalid" do
      expect( lambda{word.guess ""} ).to raise_error(InvalidGuessError)
      expect( lambda{word.guess " "} ).to raise_error(InvalidGuessError)
      expect( lambda{word.guess "blah"} ).to raise_error(InvalidGuessError)
    end

  end

  # I can guess the word by typing ! when prompted to guess a letter
  # If I guess the word correctly, I have won the game
  # If I guess the word incorrectly, I lose my turn
  describe "when guessing the word" do
    before(:each) { word.test_override "OREO" }

    # I can guess the word by typing ! when prompted to guess a letter
    # If I guess the word correctly, I have won the game
    it "it returns a win condition on a correct word guess" do
      expect(word.guess_word("OREO")).to eql({win: true})
    end

    # If I guess the word incorrectly, I lose my turn 
    it "it returns an advance turn condition on an incorrect word guess" do
      expect(word.guess_word("NOTOREO")).to eql({advance: true, message: "Nope, sorry!"})
    end

    it "it raises an error on a blank word guess" do
      expect( lambda {word.guess_word("")} ).to raise_error(InvalidGuessError)
    end
  end



end
