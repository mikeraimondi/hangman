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
      @view.start_game
      take_turns
    rescue GameError
      @view.error "Oops, you broke it"
      setup_game
    end
  end

  def take_turns
    begin
      while @game.in_progress
        advance = false
        while !advance 
          @view.notify(@game.word.display)
          player_guess = @view.prompt "#{@game.player_turn.name}, guess a letter, or enter ! to solve the puzzle:"
          begin
            response = @game.word.guess(player_guess)
            advance = response[:advance]
            @view.notify(response[:message])
          rescue InvalidGuessError
            @view.error "Please enter one letter"
          end
        end
        @game.take_turn
        @view.notify("***")
      end
    rescue GameError
      @view.error "Oops, you broke it"
      setup_game
    end
  end


end
