require 'game'
require 'input_output'
require 'validator'
require 'grid'

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
      expect(game.get_valid_move).to eq(1)
    end

    it "returns move if move is valid" do
      input = StringIO.new("1")
      input_output = InputOutput.new(output, input)
      game = new_game_instance(input_output)
      expect(game.get_valid_move).to eq(1)
    end

    it "displays prompt and gets move until move is valid" do
      input = StringIO.new("0\n1")
      input_output = InputOutput.new(output, input)
      game = new_game_instance(input_output)
      game.get_valid_move
      expect(output.string).to include("Time to place your mark! Please choose a number from 1 - 9\n")
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

    it "gets player's move and shows grid updated with move" do
     input = StringIO.new("1")
     input_output = InputOutput.new(output, input)
     game = new_game_instance(input_output)
     expect(game.get_move_and_update_grid("X", [["| 1 ", "| 2 |", " 3 |",], ["| 4 ", "| 5 |" , " 6 |"], ["| 7 ", "| 8 |", " 9 |"]])).to eq([["| X ", "| 2 |", " 3 |",], ["| 4 ", "| 5 |" , " 6 |"], ["| 7 ", "| 8 |", " 9 |"]])
   end

    it "ends game and displays grid when player gets 1, 2, 3 in a row" do
      input = StringIO.new("x\n1\n2\n3")
      input_output = InputOutput.new(output, input)
      game = new_game_instance(input_output)
      game.game_flow
      expect(output.string).to include("""
 --- --- ---
| X | X | X |
 --- --- ---
| 4 | 5 | 6 |
 --- --- ---
| 7 | 8 | 9 |
 --- --- ---\n""")
    end

    it "ends game and displays grid when mark is 'O' and player gets 1, 2, 3 in a row" do
      input = StringIO.new("o\n1\n2\n3")
      input_output = InputOutput.new(output, input)
      game = new_game_instance(input_output)
      game.game_flow
      expect(output.string).to include("""
 --- --- ---
| O | O | O |
 --- --- ---
| 4 | 5 | 6 |
 --- --- ---
| 7 | 8 | 9 |
 --- --- ---\n""")
    end

    it "ends game and displays grid when mark is 'X' and player gets 4, 5, 6 in a row" do
      input = StringIO.new("x\n4\n5\n6")
      input_output = InputOutput.new(output, input)
      game = new_game_instance(input_output)
      game.game_flow
      expect(output.string).to include("""
 --- --- ---
| 1 | 2 | 3 |
 --- --- ---
| X | X | X |
 --- --- ---
| 7 | 8 | 9 |
 --- --- ---\n""")
    end
  end

  def new_game_instance(input_output)
    game = Game.new(input_output, validator, grid, converter)
  end

end
