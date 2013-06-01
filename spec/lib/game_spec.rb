require 'rspec'
require_relative '../../lib/game'

describe Game do
  let(:game) { Game.new }

  context "setting the number of players" do
    # As a hangman player
    # I want to specify the number of players
    # So that I can play with friends
    it "has a number of players" do
      game.set_number_of_players('2')
      expect(game.player_count).to eql(2)
    end

    # I must enter a valid number
    it "raises an error if the number of players is a float" do
      expect(lambda {game.set_number_of_players "3.5"}).to raise_error(PlayerCountError)
    end

    it "raises an error if the number of players has letters" do
      expect(lambda {game.set_number_of_players 'foo'}).to raise_error(PlayerCountError)
    end

    # The number cannot be greater than 5
    it "raises an error if the number of players is greater than 5" do
      expect(lambda {game.set_number_of_players '6'}).to raise_error(PlayerCountError)
    end

    it "raises an error if the number of players is less than 1" do
      expect(lambda {game.set_number_of_players '0'}).to raise_error(PlayerCountError)
    end
  end

  # As a hangman player
  # I want to specify my name
  # So that I can identify myself

  # For every player, I must specify a name.
  it "raises an error if names are supplied without the player count defined" do
    expect( lambda {game.add_player("John")} ).to raise_error(GameError)
  end

  context "with number of players set to 2" do
    before(:each) { game.set_number_of_players('2') }

    it "has players" do
      game.add_player("John")
      game.add_player("Jane")
      expect(game.players).to have(2).items
    end

    it "has players with names" do
      game.add_player("John")
      game.add_player("Jane")
      john = game.players.first
      expect(john.name).to eql("John")
    end

    
    it "raises an error if the player name is blank" do
      expect( lambda {game.add_player("")} ).to raise_error(PlayerNameError)
      expect( lambda {game.add_player("  ")} ).to raise_error(PlayerNameError)
    end

    # Each name must be unique - if a name has already been taken, I should be prompted to supply a different name
    it "raises an error if the player name has already been taken" do
      game.add_player("John")
      expect( lambda {game.add_player("John")} ).to raise_error(PlayerNameDuplicateError)
    end

    # All names must be entered before you can proceed with the game
    it "will not start the game without all players' names" do
      game.add_player("John")
      expect( lambda {game.take_turn} ).to raise_error(PlayerNameError)
    end
  end

  it "raises an error if too many player names are entered" do
    game.set_number_of_players('1')
    game.add_player("John")
    
    expect( lambda {game.add_player("Jane")} ).to raise_error(GameError)
  end

  # As a hangman player
  # I want the turn order to be randomized
  # So that no one has an unfair advantage
  describe "with a random turn order" do

    before(:each) do 
      game.set_number_of_players('2')
      game.add_player("John")
      game.add_player("Jane")
    end

    it "has a turn order" do
      expect(game.player_turn).to be_a(Player)
    end

    it "has a turn order that progresses" do
      first_turn_player = game.player_turn
      game.take_turn
      expect(game.player_turn).to_not eql(first_turn_player)
      game.take_turn
      expect(game.player_turn).to eql(first_turn_player)
    end

    # It is random what user plays when
    it "has a random initial turn" do
      initial_player = game.player_turn
      different = false
      100.times do
        game = Game.new
        game.set_number_of_players('2')
        game.add_player("John")
        game.add_player("Jane")
        if game.player_turn.name != initial_player.name
          different = true
          break
        end
      end
      expect(different).to be_true
    end

  end

  it "has a word" do
    expect(game.word.secret).to be_a(String)
  end




end
