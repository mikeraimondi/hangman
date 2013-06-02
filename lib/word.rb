class InvalidGuessError < StandardError
end

class Word
  attr_reader :secret

  def initialize
    corpus = []
    path = File.expand_path('../../Words/Words/en.txt', __FILE__)
    File.open(path).each_line { |line| corpus << line.chomp }
    @secret = corpus.sample.upcase
    @guessed = [] 
    @secret.length.times { @guessed << false}
    @guesses = []
  end

  def display
    displayed_word = ""
    @secret.length.times do |i|
      if @guessed[i]
        displayed_word << @secret[i]
      else
        displayed_word << "_"
      end
    end
    displayed_word
  end

  def guess letter
    raise InvalidGuessError if letter.strip.empty? || letter.length > 1
    letter = letter[0].upcase
    if @guesses.include?(letter)
      return {advance: false, message: "#{letter} has already been played, silly!"}
    else
      @guesses << letter
    end
    @guessed.each_with_index do |guessed_pos, index|
      if guessed_pos
        if letter == secret[index]
          return {advance: false, message: "#{letter} has already been played, silly!"}
        end
      else
        if letter == secret[index]
          reveal_all(letter)
          return {advance: true, message: "We found #{letter}!"}
        end
      end
    end
    {advance: true, message: "Sorry, we did not find #{letter}!"}
  end

  def guess_word word
    raise InvalidGuessError if word.strip.empty?
    word = word.upcase
    word == @secret ? {advance: true, win: true} : {advance: true, message: "Nope, sorry!"}
  end

  def reveal_all letter
    @guessed.each_with_index do |guessed_pos, index|
      if letter == secret[index]
        @guessed[index] = true
      end
    end
  end

  def test_override test_word
    @secret = test_word
    @guessed = []
    @secret.length.times { @guessed << false}
  end

end
