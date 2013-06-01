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

end
