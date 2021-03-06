require 'computer_player'
require 'grid'

RSpec.describe ComputerPlayer do

  let(:grid) { Grid.new }
  let(:computer_player) { ComputerPlayer.new(grid) }
  let(:player_mark) { "O" }
  let(:opponent_mark) { "X" }
  let(:unmarked_move_sequences) { [[1, 2, 3], [4, 5, 6], [7, 8, 9], [1, 4, 7], [2, 5, 8], [3, 6, 9], [1, 5, 9], [3, 5, 7]] }
  let(:unmarked_grid) { [["| 1 ", "| 2 |", " 3 |"], ["| 4 ", "| 5 |" , " 6 |"], ["| 7 ", "| 8 |", " 9 |"]] }

  context "Gets a valid move" do
    it "gets a valid move from the computer player" do
      current_grid = [1, 2, 3, 4, 5, 6, 7, 8, 9]
      possible_moves = [1, 2, 3, 4, 5, 6, 7, 8, 9]
      computer_move = computer_player.get_valid_move(current_grid, unmarked_move_sequences, "X", "O")
      expect(possible_moves.include?(computer_move)).to eq(true)
    end

    it "stops computer player repeating the same move after it has blocked a fork" do
      move_sequences = [[1, 2, "X"], ["O", "O", "X"], ["X", 8, 9], [1, "O", "X"], [2, "O", 8], ["X", "X", 9], [1, "O", 9], ["X", "O", 7]]
      current_grid = [1, 2, "X", "O", "O", "X", "X", 8, 9]
      expect(computer_player.get_valid_move(current_grid, move_sequences, player_mark, opponent_mark)).to eq(9)
    end
  end

  context "Plays a strategic move" do
    it "plays 5 as first move" do
      opponent_mark = "O"
      expect(computer_player.get_valid_move(unmarked_grid, unmarked_move_sequences, player_mark, opponent_mark)).to eq(5)
    end

    it "plays a corner move as the first move if 5 is taken" do
      move_sequences = [[1, 2, 3], ["X", 5, 6], [7, 8, 9], [1, "4", 7], [2, 5, 8], [3, 6, 9], [1, 5, 9], [3, 5, 7]]
      current_grid = [1, 2, 3, 4, "X", 6, 7, 8, 9]
      corner_moves = [1, 3, 7, 9]
      expect(corner_moves.include?(computer_player.get_valid_move(current_grid, move_sequences, player_mark, opponent_mark))).to eq(true)
    end

    it "plays a move choosing from the only available moves left" do
      move_sequences = [["X", 2, "O"], ["O", "X", "X"], ["X", 8, "O"], ["X", "O", "X"], [2, "X", 8], ["O", "X", "O"], ["X", "X", "O"], ["O", "X", "X"]]
      current_grid = ["X", 2, "O", "O", "X" , "X", "X", 8, "O"]
      available_moves = [2, 8]
      expect(available_moves.include?(computer_player.get_valid_move(current_grid, move_sequences, player_mark, opponent_mark))).to eq(true)
    end

    it "plays 1 if opponent has played 4, 2" do
      current_grid = [1, "X", 3, "X", "O", 6, 7, 8, 9]
      move_sequences = [[1, "X", 3], ["X", "O", 6], [7, 8, 9], [1, "X", 7], ["X", "O", 8], [3, 6, 9], [1, "O", 9], [3, "O", 7]]
      expect(computer_player.get_valid_move(current_grid, move_sequences, player_mark, opponent_mark)).to eq(1)
    end

    it "plays 3 if opponent has played 2, 6" do
      current_grid = [1, "X", 3, 4, "O", "X", 7, 8, 9]
      move_sequences = [[1, "X", 3], [4, "O", "X"], [7, 8, 9], [1, 4, 7], ["X", "O", 8], [3, 6, 9], [1, "O", 9], [3, "O", 7]]
      expect(computer_player.get_valid_move(current_grid, move_sequences, player_mark, opponent_mark)).to eq(3)
    end

    it "plays 9 if opponent has played 6, 8" do
      current_grid = [1, 2, 3, 4, "O", "X", 7, "X", 9]
      move_sequences = [[1, 2, 3], [4, "O", "X"], [7, "X", 9], [1, 4, 7], [2, "O", "X"], [3, "X", 9], [1, "O", 9], [3, "O", 7]]
      expect(computer_player.get_valid_move(current_grid, move_sequences, player_mark, opponent_mark)).to eq(9)
    end

    it "plays 7 if opponent plays 8, 4" do
      current_grid = [1, 2, 3, "X", "O", 6, 7, "X", 9]
      move_sequences = [[1, 2, 3], ["X", "O", 6], [7, "X", 9], [1, "X", 7], [2, "O", "X"], [3, 6, 9], [1, "O", 9], [3, "O", 7]]
      expect(computer_player.get_valid_move(current_grid, move_sequences, player_mark, opponent_mark)).to eq(7)
    end

    it "plays 6 if opponent plays 1, 9" do
      current_grid = ["X", 2, 3, 4, "O", 6, 7, 8, "X"]
      move_sequences = [["X", 2, 3], [4, "O", 6], [7, 8, "X"], ["X", 4, 7], [2, "O", 8], [3, 6, "X"], ["X", "O", "X"], [3, "O", 7]]
      expect(computer_player.get_valid_move(current_grid, move_sequences, player_mark, opponent_mark)).to eq(6)
    end

    it "plays 4 if opponent plays 3,7" do
      current_grid = [1, 2, "X", 4, "O", 6, "X", 8, 9]
      move_sequences = [[1, 2, "X"], [4, "O", 6], ["X", 8, 9], [1, 4, "X"], [2, "O", 8], ["X", 6, 9], [1, "O", 9], ["X", "O", "X"]]
      expect(computer_player.get_valid_move(current_grid, move_sequences, player_mark, opponent_mark)).to eq(4)
    end

    it "plays 1 if opponent is 'O' and has played 4, 2" do
      move_sequences = [[1, "O", 3], ["O", "X", 6], [7, "X", 9], [1, "O", 7], ["O", "X", "X"], [3, 6, 9], [1, "X", 9], [3, "X", 7]]
      current_grid = [1, "O", 3, "O", "X", 6, 7, "X", 9]
      opponent_mark = "O"
      expect(computer_player.get_valid_move(current_grid, move_sequences, player_mark, opponent_mark)).to eq(1)
    end

    it "plays side move 4 to block a fork" do
      current_grid = [1, 2, "X", 4, "O", 6, "X", 8, 9]
      move_sequences = [[1, 2, "X"], [4, "O", 6], ["X", 8, 9], [1, 4, "X"], [2, "O", 8], ["X", 6, 9], [1, "O", 9], ["X", "O", "X"]]
      expect(computer_player.get_valid_move(current_grid, move_sequences, player_mark, opponent_mark)).to eq(4)
    end
  end

  context "Plays a winning move" do
    it "chooses to play winning move before blocking" do
      move_sequences = [["X", 2, "O"], [4, "X", 6], ["X", 8, "O"], ["X", 4, "X"], [2, "X", 8], ["O", 6, "O"], ["X", "X", "O"], ["O", "X", "X"]]
      current_grid = ["X", 2, "O", 4, "X", 6, "X", 8, "O"]
      expect(computer_player.get_valid_move(current_grid, move_sequences, player_mark, opponent_mark)).to eq(6)
    end

    it "plays 6 as the winning move" do
      move_sequences = [["X", "O", "X"], [4, "O", 6], ["O", 8, "X"], ["X", 4, "O"], ["O", "O", 8], ["X", 6, "X"], ["X", "O", "X"], ["X", "O", "O"]]
      current_grid = ["X", "O", "X", 4, "O", 6, "O", 8, "X"]
      opponent_mark = "O"
      expect(computer_player.get_valid_move(current_grid, move_sequences, "X", opponent_mark)).to eq(6)
    end

    it "plays 5 as the winning move" do
      move_sequences = [["X", "O", "X"], [4, 5, "O"], ["O", 8, "X"], ["X", 4, "O"], ["O", 5, 8], ["X", "O", "X"], ["X", 5, "X"], ["X", 5, "O"]]
      current_grid = ["X", "O", "X", 4, 5, "O", "O", 8, "X"]
      opponent_mark = "O"
      expect(computer_player.get_valid_move(current_grid, move_sequences, "X", opponent_mark)).to eq(5)
    end

    it "plays 9 as the winning move" do
      move_sequences = [[1, 2, "X"], ["O", "X", "X"], ["O", "O", 9], [1, "O", "O"], [2, "X", "O"], ["X", "X", 9], [1, "X", 9], ["X", "X", "O"]]
      current_grid = [1, 2, "X", "O", "X", "X", "O", "O", 9]
      opponent_mark = "O"
      expect(computer_player.get_valid_move(current_grid, move_sequences, "X", opponent_mark)).to eq(9)
    end

    it "plays 6 as the winning move if the opponent mark is 'X' " do
      move_sequences = [["O", "X", "O"], [4, "X", 6], ["X", 8, "O"], ["O", 4, "X"], ["X", "X", 8], ["O", 6, "O"], ["O", "X", "O"], ["O", "X", "X"]]
      current_grid = ["O", "X", "O", 4, "X", 6, "X", 8, "O"]
      expect(computer_player.get_valid_move(current_grid, move_sequences, player_mark, opponent_mark)).to eq(6)
    end

    it "returns 3 if sequence has 2 player marks and one available move" do
      move_sequences = [["X", "X", 3], [4, "O", 6], [7, 8, 9], ["X", 4, 7], ["X", "O", 8], [3, 6, 9], ["X", "O", 9], [3, "O", 7]]
      current_grid = ["X", "X", 3, 4, "O", 6, 7, 8, 9]
      opponent_mark = "O"
      expect(computer_player.get_valid_move(current_grid, move_sequences, "X", opponent_mark)).to eq(3)
    end
  end

  context "Defends against opponent" do
    it "plays 9 to block the opponent's winning move" do
      move_sequences = [[1, 2, "X"], [4, "X", 6], ["O", "O", 9], [1, 4, "O"], [2, "X", "O"], ["X", 6, 9], [1, "X", 9], ["X", "X", "O"]]
      current_grid = [1, 2, "X", 4, "X", 6, "O", "O", 9]
      opponent_mark = "O"
      expect(computer_player.get_valid_move(current_grid, move_sequences, "X", opponent_mark)).to eq(9)
    end

    it "plays 8 to block the opponent's winning move" do
      move_sequences = [["X", 2, 3], [4, "X", 6], ["O", 8, "O"], ["X", 4, "O"], [2, "X", 8], [3, 6, "O"], ["X", "X", "O"], [3, "X", "O"]]
      current_grid = ["X", 2, 3, 4, "X", 6, "O", 8, "O"]
      opponent_mark = "O"
      expect(computer_player.get_valid_move(current_grid, move_sequences, "X", opponent_mark)).to eq(8)
    end

    it "plays 6 to block the opponent's winning move" do
      move_sequences = [["X", 2, 3], ["O", "O", 6], ["X", 8, 9], ["X", "O", "X"], [2, 5, 8], [3, 6, 9], ["X", "O", 9], [3, "O", "X"]]
      current_grid = ["X", 2, 3, "O", "O", 6, "X", 8, 9]
      opponent_mark = "O"
      expect(computer_player.get_valid_move(current_grid, move_sequences, "X", opponent_mark)).to eq(6)
    end

    it "blocks a winning move before it blocks a fork" do
      current_grid = [1, 2, "O", "O", "X", "X", 7, "X", 9]
      move_sequences = [[1, 2, "O"], ["O", "X", "X"], [7, "X", 9], [1, "O", 7], [2, "X", 'X'], ["O", "X", 9], [1, "X", 9], ["O", "X", 7]]
      expect(computer_player.get_valid_move(current_grid, move_sequences, player_mark, opponent_mark)).to eq(2)
    end
  end
end
