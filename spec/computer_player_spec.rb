require 'computer_player'

RSpec.describe ComputerPlayer do

  it "plays a random move" do
    computer_player = ComputerPlayer.new
    possible_moves = [1, 2, 3, 4, 5, 6, 7, 8, 9]
    expect(possible_moves.include?(computer_player.play_move)).to eq(true)
  end
end
