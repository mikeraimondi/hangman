require_relative 'game'
require_relative 'view'
require 'pry'

class Controller

  def initialize
    @game = Game.new
    @view = View.new
  end

  def start_game
    while @game.player_count.nil?
      begin
        @player_count = @view.prompt_for_player_count
        @game.set_number_of_players(@player_count)
      rescue PlayerCountError
        @view.error "Please enter an integer between 1 and 5"
      end
    end

    @view.display @game.player_count
  end

end
