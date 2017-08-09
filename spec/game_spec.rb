require 'game'
require 'input_output'
require 'validator'
require 'grid'
require 'converter'
require 'human_player'
require 'computer_player'

RSpec.describe Game do

  let(:output) { StringIO.new }
  let(:input) { StringIO.new }
  let(:input_output) { InputOutput.new(output) }
  let(:validator) { Validator.new }
  let(:grid) { Grid.new }
  let(:converter) { Converter.new }
  let(:human_player) { HumanPlayer.new(input_output) }
  let(:computer_player) { ComputerPlayer.new(grid) }

  context "Gets a valid move" do
    it "gets a player move" do
      input = StringIO.new("1")
      game = new_game_instance(input_output, human_player)
      current_grid = [["| 1 ", "| 2 |", " 3 |",], ["| 4 ", "| 5 |" , " 6 |"], ["| 7 ", "| 8 |", " 9 |"]]
      player_type = HumanPlayer.new(io_instance_with_input(output, input))
      move_sequences = [[1, 2, 3], [4, 5, 6], [7, 8, 9], [1, 4, 7], [2, 5, 8], [3, 6, 9], [1, 5, 9], [3, 5, 7]]
      expect(game.get_valid_move(current_grid, player_type, move_sequences, "X")).to eq(1)
    end

    it "returns move if move is valid" do
      input = StringIO.new("1")
      game = new_game_instance(input_output, human_player)
      current_grid = [["| 1 ", "| 2 |", " 3 |",], ["| 4 ", "| 5 |" , " 6 |"], ["| 7 ", "| 8 |", " 9 |"]]
      player_type = HumanPlayer.new(io_instance_with_input(output, input))
      move_sequences = [[1, 2, 3], [4, 5, 6], [7, 8, 9], [1, 4, 7], [2, 5, 8], [3, 6, 9], [1, 5, 9], [3, 5, 7]]
      expect(game.get_valid_move(current_grid, player_type, move_sequences, "X")).to eq(1)
    end

    it "displays error message and gets move until move is valid" do
      input = StringIO.new("0\n1")
      game = new_game_instance(input_output, human_player)
      current_grid = [["| 1 ", "| 2 |", " 3 |",], ["| 4 ", "| 5 |" , " 6 |"], ["| 7 ", "| 8 |", " 9 |"]]
      player_type = HumanPlayer.new(io_instance_with_input(output, input))
      move_sequences = [[1, 2, 3], [4, 5, 6], [7, 8, 9], [1, 4, 7], [2, 5, 8], [3, 6, 9], [1, 5, 9], [3, 5, 7]]
      game.get_valid_move(current_grid, player_type, move_sequences, "X")
      expect(output.string).to include("This move is invalid. Please enter another one\n")
    end

    it "displays error message if the same move is entered twice" do
      input = StringIO.new("1\n2")
      game = new_game_instance(input_output, human_player)
      current_grid_with_mark = [["| X ", "| 2 |", " 3 |",], ["| 4 ", "| 5 |" , " 6 |"], ["| 7 ", "| 8 |", " 9 |"]]
      player_type = HumanPlayer.new(io_instance_with_input(output, input))
      move_sequences = [[1, 2, 3], [4, 5, 6], [7, 8, 9], [1, 4, 7], [2, 5, 8], [3, 6, 9], [1, 5, 9], [3, 5, 7]]
      game.get_valid_move(current_grid_with_mark, player_type, move_sequences, "X")
      expect(output.string).to include("This move is invalid. Please enter another one\n")
    end

    it "gets a valid move from the computer player" do
      game = new_game_instance(input_output, human_player)
      current_grid = [["| 1 ", "| 2 |", " 3 |",], ["| 4 ", "| 5 |" , " 6 |"], ["| 7 ", "| 8 |", " 9 |"]]
      player_type = ComputerPlayer.new(grid)
      possible_moves = [1, 2, 3, 4, 5, 6, 7, 8, 9]
      move_sequences = [[1, 2, 3], [4, 5, 6], [7, 8, 9], [1, 4, 7], [2, 5, 8], [3, 6, 9], [1, 5, 9], [3, 5, 7]]
      computer_move = game.get_valid_move(current_grid, player_type, move_sequences, "X")
      expect(possible_moves.include?(computer_move)).to eq(true)
    end
  end

  context "Displaying and updating grid" do
    it "shows player the initial grid" do
      game = new_game_instance(input_output, human_player)
      game.initial_grid
      expect(output.string).to eq("""
 --- --- ---
| 1 | 2 | 3 |
 --- --- ---
| 4 | 5 | 6 |
 --- --- ---
| 7 | 8 | 9 |
 --- --- ---\n""")
    end

    it "ends game and displays grid when player 1 enters 1, 2, 3 in a row" do
      input = StringIO.new("1\n1\n4\n2\n8\n3")
      input_output = InputOutput.new(output, input)
      human_player_with_input = HumanPlayer.new(input_output)
      game = new_game_instance(input_output, human_player_with_input)
      game.game_flow
      expect(output.string).to include("""
 --- --- ---
| X | X | X |
 --- --- ---
| O | 5 | 6 |
 --- --- ---
| 7 | O | 9 |
 --- --- ---\n""")
    end

    it "ends game and displays grid when p1 enters 4, 5, 6" do
      input = StringIO.new("1\n4\n1\n5\n9\n6")
      input_output = InputOutput.new(output, input)
      human_player_with_input = HumanPlayer.new(input_output)
      game = new_game_instance(input_output, human_player_with_input)
      game.game_flow
      expect(output.string).to include("""
 --- --- ---
| O | 2 | 3 |
 --- --- ---
| X | X | X |
 --- --- ---
| 7 | 8 | O |
 --- --- ---\n""")
    end

    it "ends game and displays grid when p1 enters 7, 8, 9" do
      input = StringIO.new("1\n7\n4\n8\n5\n9")
      input_output = InputOutput.new(output, input)
      human_player_with_input = HumanPlayer.new(input_output)
      game = new_game_instance(input_output, human_player_with_input)
      game.game_flow
      expect(output.string).to include("""
 --- --- ---
| 1 | 2 | 3 |
 --- --- ---
| O | O | 6 |
 --- --- ---
| X | X | X |
 --- --- ---\n""")
    end

    it "ends game and displays grid when p1 enters 1, 4, 7" do
      input = StringIO.new("1\n1\n5\n4\n3\n7")
      input_output = InputOutput.new(output, input)
      human_player_with_input = HumanPlayer.new(input_output)
      game = new_game_instance(input_output, human_player_with_input)
      game.game_flow
      expect(output.string).to include("""
 --- --- ---
| X | 2 | O |
 --- --- ---
| X | O | 6 |
 --- --- ---
| X | 8 | 9 |
 --- --- ---\n""")
    end

    it "ends game and displays grid when p1 enters 2, 5, 8" do
      input = StringIO.new("1\n2\n1\n5\n4\n8")
      input_output = InputOutput.new(output, input)
      human_player_with_input = HumanPlayer.new(input_output)
      game = new_game_instance(input_output, human_player_with_input)
      game.game_flow
      expect(output.string).to include("""
 --- --- ---
| O | X | 3 |
 --- --- ---
| O | X | 6 |
 --- --- ---
| 7 | X | 9 |
 --- --- ---\n""")
    end

    it "ends game and displays grid when p1 enters 3, 6, 9" do
      input = StringIO.new("1\n3\n2\n6\n5\n9")
      input_output = InputOutput.new(output, input)
      human_player_with_input = HumanPlayer.new(input_output)
      game = new_game_instance(input_output, human_player_with_input)
      game.game_flow
      expect(output.string).to include("""
 --- --- ---
| 1 | O | X |
 --- --- ---
| 4 | O | X |
 --- --- ---
| 7 | 8 | X |
 --- --- ---\n""")
    end

    it "ends game and displays grid when p1 enters 1, 5, 9" do
      input = StringIO.new("1\n1\n2\n5\n4\n9")
      input_output = InputOutput.new(output, input)
      human_player_with_input = HumanPlayer.new(input_output)
      game = new_game_instance(input_output, human_player_with_input)
      game.game_flow
      expect(output.string).to include("""
 --- --- ---
| X | O | 3 |
 --- --- ---
| O | X | 6 |
 --- --- ---
| 7 | 8 | X |
 --- --- ---\n""")
    end

    it "ends game and displays grid when p1 enters 3, 5, 7" do
      input = StringIO.new("1\n3\n6\n5\n4\n7")
      input_output = InputOutput.new(output, input)
      human_player_with_input = HumanPlayer.new(input_output)
      game = new_game_instance(input_output, human_player_with_input)
      game.game_flow
      expect(output.string).to include("""
 --- --- ---
| 1 | 2 | X |
 --- --- ---
| O | X | O |
 --- --- ---
| X | 8 | 9 |
 --- --- ---\n""")
    end

    it "ends game and displays grid when p1 enters 4, 1, 2, 3" do
      input = StringIO.new("1\n4\n5\n1\n6\n2\n7\n3")
      input_output = InputOutput.new(output, input)
      human_player_with_input = HumanPlayer.new(input_output)
      game = new_game_instance(input_output, human_player_with_input)
      game.game_flow
      expect(output.string).to include("""
 --- --- ---
| X | X | X |
 --- --- ---
| X | O | O |
 --- --- ---
| O | 8 | 9 |
 --- --- ---\n""")
    end

    it "ends game and displays grid when unordered moves 4, 1, 3, 2" do
      input = StringIO.new("1\n4\n5\n1\n7\n3\n\n8\n2")
      input_output = InputOutput.new(output, input)
      human_player_with_input = HumanPlayer.new(input_output)
      game = new_game_instance(input_output, human_player_with_input)
      game.game_flow
      expect(output.string).to include("""
 --- --- ---
| X | X | X |
 --- --- ---
| X | O | 6 |
 --- --- ---
| O | O | 9 |
 --- --- ---\n""")
    end

    it "ends game when winning sequence is not ordered and moves aren't consecutive" do
      input = StringIO.new("1\n2\n8\n3\n5\n4\n6\n1")
      input_output = InputOutput.new(output, input)
      human_player_with_input = HumanPlayer.new(input_output)
      game = new_game_instance(input_output, human_player_with_input)
      game.game_flow
      expect(output.string).to include("""
 --- --- ---
| X | X | X |
 --- --- ---
| X | O | O |
 --- --- ---
| 7 | O | 9 |
 --- --- ---\n""")
    end

    it "ends the game as soon as a player has won" do
      input = StringIO.new("1\n1\n3\n4\n5\n7")
      input_output = InputOutput.new(output, input)
      human_player_with_input = HumanPlayer.new(input_output)
      game = new_game_instance(input_output, human_player_with_input)
      game.game_flow
      expect(output.string).to include("""
 --- --- ---
| X | 2 | O |
 --- --- ---
| X | O | 6 |
 --- --- ---
| X | 8 | 9 |
 --- --- ---\n""")
    end

    it "ends the game when neither player has won" do
      input = StringIO.new("1\n1\n2\n3\n4\n5\n6\n8\n7\n9")
      input_output = InputOutput.new(output, input)
      human_player_with_input = HumanPlayer.new(input_output)
      game = new_game_instance(input_output, human_player_with_input)
      game.game_flow
      expect(output.string).to include("""
 --- --- ---
| X | O | X |
 --- --- ---
| O | X | O |
 --- --- ---
| O | X | X |
 --- --- ---\n""")
    end
  end

  context "Tracks the game status" do
    it "returns true if the game has been won" do
      game = new_game_instance(input_output, human_player)
      expect(game.game_is_over?([["O", "O", "O"], ["X", "X", 6], ["X", 8, "X"], ["O", "X", "X"], ["O", "X", 8], ["O", 6, "X"], ["O", "X", "X"], ["O", "X", "X"]], [["O", "O", "O"]])).to eq(true)
    end

    it "returns a list of winning moves with instances of 1 replaced with marked_move" do
      game = new_game_instance(input_output, human_player)
      winning_moves = [[1, 2, 3], [4, 5, 6], [7, 8, 9], [1, 4, 7], [2, 5, 8], [3, 6, 9], [1, 5, 9], [3, 5, 7]]
      expect(game.get_winning_hits(winning_moves, 1, "X")).to eq([["X", 2, 3], [4, 5, 6], [7, 8, 9], ["X", 4, 7], [2, 5, 8], [3, 6, 9], ["X", 5, 9], [3, 5, 7]])
    end

    it "returns 'Game over. Player 1 wins!' if 'X' wins" do
      game = new_game_instance(input_output, human_player)
      current_grid = [["| X ", "| X |", " X |"], ["| O ", "| O |" , " 6 |"], ["| 7 ", "| 8 |", " 9 |"]]
      game.get_end_score(current_grid)
      expect(output.string).to eq("Game over. Player 1 wins!\n")
    end

    it "returns 'Game over. Player 2 wins!' if 'O' wins" do
      game = new_game_instance(input_output, human_player)
      current_grid = [["| X ", "| X |", " O |"], ["| X ", "| O |" , " 6 |"], ["| O ", "| 8 |", " 9 |"]]
      game.get_end_score(current_grid)
      expect(output.string).to eq("Game over. Player 2 wins!\n")
    end

    it "returns 'Game over. It's a tie!' if neither player wins" do
      game = new_game_instance(input_output, human_player)
      current_grid = [["| X ", "| O |", " X |"], ["| X ", "| O |" , " O |"], ["| O ", "| X |", " X |"]]
      game.get_end_score(current_grid)
      expect(output.string).to eq("Game over. It's a tie!\n")
    end

    it "ends and scores game when neither player has won and no moves are left" do
      input = StringIO.new("2\n1\n3\n8\n7\n9\n4\n6")
      input_output = InputOutput.new(output, input)
      human_player_with_input = HumanPlayer.new(input_output)
      game = new_game_instance(input_output, human_player_with_input)
      game.game_flow
      expect(output.string).to include("Game over. It's a tie!")
    end

    it "is impossible to beat the computer when human plays 1, 9, 4, 3, 8" do
      input = StringIO.new("2\n1\n9\n4\n3\n8")
      input_output = InputOutput.new(output, input)
      human_player_with_input = HumanPlayer.new(input_output)
      game = new_game_instance(input_output, human_player_with_input)
      game.game_flow
      expect(output.string).to include("""
 --- --- ---
| X | O | X |
 --- --- ---
| X | O | O |
 --- --- ---
| O | X | X |
 --- --- ---\n""")
      expect(output.string).to include("Game over. It's a tie!")
    end

    it "is impossible to beat the computer when human plays 3, 7, 6, 1, 8" do
      input = StringIO.new("2\n3\n7\n6\n1\n8")
      input_output = InputOutput.new(output, input)
      human_player_with_input = HumanPlayer.new(input_output)
      game = new_game_instance(input_output, human_player_with_input)
      game.game_flow
      expect(output.string).to include("""
 --- --- ---
| X | O | X |
 --- --- ---
| O | O | X |
 --- --- ---
| X | X | O |
 --- --- ---\n""")
      expect(output.string).to include("Game over. It's a tie!")
    end
  end

  it "returns 'O' if p1's mark is 'X' " do
    game = new_game_instance(input_output, human_player)
    expect(game.get_mark_for_p2("X")).to eq("O")
  end

  it "returns 'X' if p1's mark is 'O' " do
    game = new_game_instance(input_output, human_player)
    expect(game.get_mark_for_p2("O")).to eq("X")
  end

  def new_game_instance(input_output, human_player)
    game = Game.new(input_output, validator, grid, converter, human_player, computer_player)
  end

  def io_instance_with_input(output, input)
    InputOutput.new(output, input)
  end

end
