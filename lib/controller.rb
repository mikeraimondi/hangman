require_relative 'game'
require_relative 'view'
require 'pry'

class Controller

  def initialize
    @game = Game.new
    @view = View.new
    setup_game
  end

  def setup_game
    begin
      while @game.player_count.nil?
        begin
          player_count = @view.prompt_for_player_count
          @game.set_number_of_players(player_count)
        rescue PlayerCountError
          @view.error "Please enter an integer between 1 and 5"
        end
      end

      @game.player_count.times do |player_num|
        prev_count = @game.players.count
        while prev_count == @game.players.count
          begin
            player = @view.prompt_for_player_name(player_num + 1)
            @game.add_player(player)
          rescue PlayerNameError
            @view.error "Please enter a name"
          rescue PlayerNameDuplicateError
            @view.error "Sorry, that name has been taken. Try again"
          end
        end
      end
      take_turns
    rescue GameError
      @view.error "Oops, you broke it"
      setup_game
    end
  end

  def take_turns
    while @game.in_progress
      @view.prompt "#{@game.player_turn.name}, guess a letter, or enter ! to solve the puzzle:"
      @game.take_turn
    end
  end


end
