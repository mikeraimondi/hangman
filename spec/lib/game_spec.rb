require 'rspec'
require_relative '../../lib/game'

describe Game do
  let(:game) { Game.new }
  before(:each) do
    game.add_player("John")
    game.add_player("Jane")
  end

  it "has players" do
    expect(game.players).to have(2).items
  end

  it "has players with names" do
    john = game.players.first
    expect(john.name).to eql("John")
  end

end
