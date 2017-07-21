require 'game'

RSpec.describe Game do

  it "gets a mark choice" do
    input = StringIO.new("x")
    output = StringIO.new
    input_output = InputOutput.new(output, input)
    game = Game.new(input_output)
    expect(game.get_player_mark).to eq('x')
  end

end
