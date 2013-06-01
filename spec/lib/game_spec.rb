require 'rspec'
require_relative '../../lib/game'

describe Game do
  let(:game) { Game.new }

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

  # As a hangman player
  # I want to specify my name
  # So that I can identify myself
  it "has players" do
    game.set_number_of_players('2')
    game.add_player("John")
    game.add_player("Jane")
    expect(game.players).to have(2).items
  end

  it "has players with names" do
    game.set_number_of_players('2')
    game.add_player("John")
    game.add_player("Jane")
    john = game.players.first
    expect(john.name).to eql("John")
  end

  # For every player, I must specify a name.
  it "raises an error if names are supplied without the player count defined" do
    expect( lambda {game.add_player("John")} ).to raise_error(GameError)
  end
  
  it "raises an error if the player name is blank" do
    game.set_number_of_players('2')
    expect( lambda {game.add_player("")} ).to raise_error(PlayerNameError)
    expect( lambda {game.add_player("  ")} ).to raise_error(PlayerNameError)
  end

  # Each name must be unique - if a name has already been taken, I should be prompted to supply a different name
  it "raises an error if the player name has already been taken" do
    game.set_number_of_players('2')
    game.add_player("John")
    expect( lambda {game.add_player("John")} ).to raise_error(PlayerNameDuplicateError)
  end

  # All names must be entered before you can proceed with the game
  it "will not start the game without all players' names" do
    game.set_number_of_players('2')
    game.add_player("John")
    expect( lambda {game.start} ).to raise_error(PlayerNameError)
  end

  it "raises an error if too many player names are entered" do
    game.set_number_of_players('1')
    game.add_player("John")
    
    expect( lambda {game.add_player("Jane")} ).to raise_error(GameError)
  end
end
