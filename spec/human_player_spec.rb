require 'human_player'
require 'input_output'

RSpec.describe HumanPlayer do

  it "plays a move" do
    input = StringIO.new("1")
    output = StringIO.new
    input_output = InputOutput.new(output, input)
    human_player = HumanPlayer.new(input_output)
    expect(human_player.play_move).to eq(1)
  end

end
