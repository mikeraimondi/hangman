require_relative 'player'
require_relative 'word'

class PlayerCountError < StandardError
end

class PlayerNameError < StandardError
end

class PlayerNameDuplicateError < StandardError
end

class GameError < StandardError
end

class Game
  attr_reader :players, :player_count, :word
  attr_accessor :in_progress

  def initialize
    @players = []
    @current_turn = 0
    @in_progress = true
    @word = Word.new
  end

  def set_number_of_players count
    raise PlayerCountError if count.to_f % 1 != 0.0
    raise PlayerCountError if count =~ /\D/
    raise PlayerCountError if count.to_i > 5 || count.to_i < 1
    @player_count = count.to_i
    randomize_turn
  end

  def randomize_turn
    max = @player_count - 1
    random_num = [*0..max].sample
    @current_turn = random_num
  end

  def add_player name
    raise GameError if @player_count.nil? || @players.count >= @player_count
    raise PlayerNameError if name.strip.empty?
    names = []
    @players.each {|player| names << player.name}
    raise PlayerNameDuplicateError if names.include? name
    @players << Player.new(name)
  end

  def player_turn
    @players[@current_turn]
  end

  def take_turn
    raise PlayerNameError if @players.count < @player_count
    if @in_progress
      @current_turn >= @players.count - 1 ? @current_turn = 0 : @current_turn += 1
    end
  end

end
