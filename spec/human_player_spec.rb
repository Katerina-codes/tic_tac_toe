require 'human_player'
require 'input_output'

RSpec.describe HumanPlayer do

  it "plays a move" do
    input = StringIO.new("1")
    output = StringIO.new
    input_output = InputOutput.new(output, input)
    human_player = HumanPlayer.new(input_output)
    move_sequences = [[1, 2, 3], [4, 5, 6], [7, 8, 9], [1, 4, 7], [2, 5, 8], [3, 6, 9], [1, 5, 9], [3, 5, 7]]
    expect(human_player.play_move(move_sequences, "X")).to eq(1)
  end

end
