require 'rspec'
require_relative '../../lib/player'

describe Player do

  it "has a name" do
    player = Player.new("John")
    expect(player.name).to eql("John")
  end
  
end
