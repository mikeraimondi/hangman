require 'player'

class PlayerCountError < StandardError
end

class Game
  attr_reader :players, :player_count

  def initialize
    @players = []
  end

  def set_number_of_players count
    raise PlayerCountError if count.to_f % 1 != 0.0
    raise PlayerCountError if count =~ /\D/
    raise PlayerCountError if count > 5 || count < 1
    @player_count = count
  end

  def add_player name
    @players << Player.new(name)
  end

end
