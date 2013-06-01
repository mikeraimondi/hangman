require_relative 'player'

class PlayerCountError < StandardError
end

class PlayerNameError < StandardError
end

class PlayerNameDuplicateError < StandardError
end

class GameError < StandardError
end

class Game
  attr_reader :players, :player_count

  def initialize
    @players = []
  end

  def set_number_of_players count
    raise PlayerCountError if count.to_f % 1 != 0.0
    raise PlayerCountError if count =~ /\D/
    raise PlayerCountError if count.to_i > 5 || count.to_i < 1
    @player_count = count.to_i
  end

  def add_player name
    raise GameError if @player_count.nil? || @players.count >= @player_count
    raise PlayerNameError if name.strip.empty?
    names = []
    @players.each {|player| names << player.name}
    raise PlayerNameDuplicateError if names.include? name
    @players << Player.new(name)
  end

  def start
    raise PlayerNameError if @players.count < @player_count
  end

end
