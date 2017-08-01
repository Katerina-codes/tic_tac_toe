require 'computer_player'

RSpec.describe ComputerPlayer do

  it "plays a random move" do
    computer_player = ComputerPlayer.new
    possible_moves = [1, 2, 3, 4, 5, 6, 7, 8, 9]
    expect(possible_moves.include?(computer_player.play_move)).to eq(true)
  end

  it "plays 7 as the 1st move" do
    computer_player = ComputerPlayer.new
    expect(computer_player.get_strategic_move([["| 1 ", "| 2 |", " 3 |"], ["| 4 ", "| 5 |" , " 6 |"], ["| 7 ", "| 8 |", " 9 |"]])).to eq(7)
  end

  it "plays 8 if player's 1st move is 4" do
  computer_player = ComputerPlayer.new
  expect(computer_player.get_strategic_move([["| 1 ", "| 2 |", " 3 |"], ["| O ", "| 5 |" , " 6 |"], ["| X ", "| 8 |", " 9 |"]])).to eq(8)
  end


end
