require 'computer_player'

RSpec.describe ComputerPlayer do

  let(:computer_player) { ComputerPlayer.new }

  it "plays a random move" do
    possible_moves = [1, 2, 3, 4, 5, 6, 7, 8, 9]
    expect(possible_moves.include?(computer_player.play_move)).to eq(true)
  end

  it "plays 7 as the 1st move" do
    expect(computer_player.get_strategic_move([["| 1 ", "| 2 |", " 3 |"], ["| 4 ", "| 5 |" , " 6 |"], ["| 7 ", "| 8 |", " 9 |"]])).to eq(7)
  end

  it "plays 8 if player's 1st move is 4" do
    expect(computer_player.get_strategic_move([["| 1 ", "| 2 |", " 3 |"], ["| O ", "| 5 |" , " 6 |"], ["| X ", "| 8 |", " 9 |"]])).to eq(8)
  end

  it "plays 5 if player's 2nd move is 9" do
    expect(computer_player.get_strategic_move([["| 1 ", "| 2 |", " 3 |"], ["| O ", "| 5 |" , " 6 |"], ["| X ", "| X |", " O |"]])).to eq(5)
  end

  it "plays 3 if player's 3rd move is 2" do
    expect(computer_player.get_strategic_move([["| 1 ", "| O |", " 3 |"], ["| O ", "| X |" , " 6 |"], ["| X ", "| X |", " O |"]])).to eq(3)
  end

  it "plays 6 as the winning move" do
    move_sequences = [["X", "O", "X"], [4, "O", 6], ["O", 8, "X"], ["X", 4, "O"], ["O", "O", 8], ["X", 6, "X"], ["X", "O", "X"], ["X", "O", "O"]]
    expect(computer_player.play_winning_move(move_sequences, "X")).to eq(6)
  end

  it "plays 5 as the winning move" do
    move_sequences = [["X", "O", "X"], [4, 5, "O"], ["O", 8, "X"], ["X", 4, "O"], ["O", 5, 8], ["X", "O", "X"], ["X", 5, "X"], ["X", 5, "O"]]
    expect(computer_player.play_winning_move(move_sequences, "X")).to eq(5)
  end

  it "plays 9 as the winning move" do
    move_sequences = [[1, 2, "X"], ["O", "X", "X"], ["O", "O", 9], [1, "O", "O"], [2, "X", "O"], ["X", "X", 9], [1, "X", 9], ["X", "X", "O"]]
    expect(computer_player.play_winning_move(move_sequences, "X")).to eq(9)
  end

  it "plays 6 as the winning move if the opponent mark is 'X' " do
    move_sequences = [["O", "X", "O"], [4, "X", 6], ["X", 8, "O"], ["O", 4, "X"], ["X", "X", 8], ["O", 6, "O"], ["O", "X", "O"], ["O", "X", "X"]]
    expect(computer_player.play_winning_move(move_sequences, "O")).to eq(6)
    end

end
