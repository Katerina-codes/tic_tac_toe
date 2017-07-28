require 'game'
require 'input_output'
require 'validator'
require 'grid'
require 'converter'

RSpec.describe Game do

  let(:output) { StringIO.new }
  let(:input) { StringIO.new }
  let(:input_output) { InputOutput.new(output) }
  let(:validator) { Validator.new }
  let(:grid) { Grid.new }
  let(:converter) { Converter.new }

  context "Gets a valid mark" do
    it "gets a mark choice" do
      input = StringIO.new("x")
      input_output = InputOutput.new(output, input)
      game = new_game_instance(input_output)
      expect(game.get_valid_mark).to eq("X")
    end

    it "returns mark if mark is 'X' " do
      input = StringIO.new("x")
      input_output = InputOutput.new(output, input)
      game = new_game_instance(input_output)
      expect(game.get_valid_mark).to eq("X")
    end

    it "returns another mark prompt if mark is not valid" do
      input = StringIO.new("z\nx")
      input_output = InputOutput.new(output, input)
      game = new_game_instance(input_output)
      game.get_valid_mark
      expect(output.string).to include("Choose your mark, type 'X' or 'O'")
    end
  end

  context "Gets a valid move" do
    it "gets a player move" do
      input = StringIO.new("1")
      input_output = InputOutput.new(output, input)
      game = new_game_instance(input_output)
      expect(game.get_valid_move([["| 1 ", "| 2 |", " 3 |",], ["| 4 ", "| 5 |" , " 6 |"], ["| 7 ", "| 8 |", " 9 |"]])).to eq(1)
    end

    it "returns move if move is valid" do
      input = StringIO.new("1")
      input_output = InputOutput.new(output, input)
      game = new_game_instance(input_output)
      expect(game.get_valid_move([["| 1 ", "| 2 |", " 3 |",], ["| 4 ", "| 5 |" , " 6 |"], ["| 7 ", "| 8 |", " 9 |"]])).to eq(1)
    end

    it "displays error message and gets move until move is valid" do
      input = StringIO.new("0\n1")
      input_output = InputOutput.new(output, input)
      game = new_game_instance(input_output)
      game.get_valid_move([["| 1 ", "| 2 |", " 3 |",], ["| 4 ", "| 5 |" , " 6 |"], ["| 7 ", "| 8 |", " 9 |"]])
      expect(output.string).to include("This move is invalid. Please enter another one\n")
    end

    it "displays error message if the same move is entered twice" do
      input = StringIO.new("1\n2")
      input_output = InputOutput.new(output, input)
      game = new_game_instance(input_output)
      game.get_valid_move([["| X ", "| 2 |", " 3 |",], ["| 4 ", "| 5 |" , " 6 |"], ["| 7 ", "| 8 |", " 9 |"]])
      expect(output.string).to include("This move is invalid. Please enter another one\n")
    end
  end

  context "Displaying and updating grid" do
    it "shows player the initial grid" do
      game = new_game_instance(input_output)
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
      input = StringIO.new("1\nx\no\n1\n4\n2\n8\n3")
      input_output = InputOutput.new(output, input)
      game = new_game_instance(input_output)
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

    it "ends game and displays grid when mark is 'O' and p2 enters 1, 2, 3" do
      input = StringIO.new("1\no\nx\n1\n9\n2\n8\n3")
      input_output = InputOutput.new(output, input)
      game = new_game_instance(input_output)
      game.game_flow
      expect(output.string).to include("""
 --- --- ---
| O | O | O |
 --- --- ---
| 4 | 5 | 6 |
 --- --- ---
| 7 | X | X |
 --- --- ---\n""")
    end

    it "ends game and displays grid when mark is 'X' and p1 enters 4, 5, 6" do
      input = StringIO.new("1\nx\no\n4\n1\n5\n9\n6")
      input_output = InputOutput.new(output, input)
      game = new_game_instance(input_output)
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

    it "ends game and displays grid when mark is 'X' p1 enters 7, 8, 9" do
      input = StringIO.new("1\nx\no\n7\n4\n8\n5\n9")
      input_output = InputOutput.new(output, input)
      game = new_game_instance(input_output)
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

    it "ends game and displays grid when mark is 'X' p1 enters 1, 4, 7" do
      input = StringIO.new("1\nx\no\n1\n5\n4\n3\n7")
      input_output = InputOutput.new(output, input)
      game = new_game_instance(input_output)
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

    it "ends game and displays grid when mark is 'X' p1 enters 2, 5, 8" do
      input = StringIO.new("1\nx\no\n2\n1\n5\n4\n8")
      input_output = InputOutput.new(output, input)
      game = new_game_instance(input_output)
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

    it "ends game and displays grid when mark is 'X' p1 enters 3, 6, 9" do
      input = StringIO.new("1\nx\no\n3\n2\n6\n5\n9")
      input_output = InputOutput.new(output, input)
      game = new_game_instance(input_output)
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

    it "ends game and displays grid when mark is 'X' p1 enters 1, 5, 9" do
      input = StringIO.new("1\nx\no\n1\n2\n5\n4\n9")
      input_output = InputOutput.new(output, input)
      game = new_game_instance(input_output)
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

    it "ends game and displays grid when mark is 'X' p1 enters 3, 5, 7" do
      input = StringIO.new("1\nx\no\n3\n6\n5\n4\n7")
      input_output = InputOutput.new(output, input)
      game = new_game_instance(input_output)
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

    it "ends game and displays grid when p1 enters more than 3 moves 4, 1, 2, 3" do
      input = StringIO.new("1\nx\no\n4\n5\n1\n6\n2\n7\n3")
      input_output = InputOutput.new(output, input)
      game = new_game_instance(input_output)
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
      input = StringIO.new("1\nx\no\n4\n5\n1\n7\n3\n\n8\n2")
      input_output = InputOutput.new(output, input)
      game = new_game_instance(input_output)
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
      input = StringIO.new("1\nx\no\n2\n8\n3\n5\n4\n6\n1")
      input_output = InputOutput.new(output, input)
      game = new_game_instance(input_output)
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
  end

  it "ends the game as soon as a player has won" do
    input = StringIO.new("1\nx\no\n1\n3\n4\n5\n7")
    input_output = InputOutput.new(output, input)
    game = new_game_instance(input_output)
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

  it "returns true if the game has been won" do
    game = new_game_instance(input_output)
    expect(game.game_is_won?([["marked_move", "marked_move", "marked_move"], [4, 5, 6], [7, 8, 9], [1, 4, 7], [2, 5, 8], [3, 6, 9], [1, 5, 9], [3, 5, 7]], [["marked_move", "marked_move", "marked_move"]])).to eq(true)
  end

  it "returns a list of winning moves with instances of 1 replaced with marked_move" do
    game = new_game_instance(input_output)
    winning_moves = [[1, 2, 3], [4, 5, 6], [7, 8, 9], [1, 4, 7], [2, 5, 8], [3, 6, 9], [1, 5, 9], [3, 5, 7]]
    expect(game.get_winning_hits(winning_moves, 1)).to eq([["marked_move", 2, 3], [4, 5, 6], [7, 8, 9], ["marked_move", 4, 7], [2, 5, 8], [3, 6, 9], ["marked_move", 5, 9], [3, 5, 7]])
  end

  it "returns 'O' if p1's mark is 'X' " do
    game = new_game_instance(input_output)
    expect(game.get_mark_for_p2("X")).to eq("O")
  end

  it "returns 'X' if p1's mark is 'O' " do
    game = new_game_instance(input_output)
    expect(game.get_mark_for_p2("O")).to eq("X")
  end

  def new_game_instance(input_output)
    game = Game.new(input_output, validator, grid, converter)
  end

end
