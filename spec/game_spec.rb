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

  context "Gets a valid mark" do

    it "gets a mark choice" do
      input = StringIO.new("x")
      input_output = InputOutput.new(output, input)
      game = Game.new(input_output, validator, grid)
      expect(game.get_player_mark).to eq('x')
    end

    it "returns mark if mark is 'x' " do
      game = Game.new(input_output, validator, grid)
      expect(game.get_valid_mark("x")).to eq("x")
    end

    it "returns another mark prompt if mark is not valid" do
      input = StringIO.new("x")
      input_output = InputOutput.new(output, input)
      game = Game.new(input_output, validator, grid)
      game.get_valid_mark("z")
      expect(output.string).to include("Choose your mark, type 'X' or 'O'")
    end

  end

  context "Gets a valid move" do

    it "gets a player move" do
      input = StringIO.new("1")
      input_output = InputOutput.new(output, input)
      game = Game.new(input_output, validator, grid)
      expect(game.get_player_move).to eq(1)
    end

    it "returns move if move is valid" do
      game = Game.new(input_output, validator, grid)
      expect(game.get_valid_move(1)).to eq(1)
    end

    it "displays prompt and gets move until move is valid" do
      input = StringIO.new("1")
      input_output = InputOutput.new(output, input)
      game = Game.new(input_output, validator, grid)
      game.get_valid_move(0)
      expect(output.string).to include("Time to place your mark! Please choose a number from 1 - 9\n")
    end

  end

  it "Player is shown the initial grid" do
    grid = Grid.new
    game = Game.new(input_output, validator, grid)
    game.initial_grid
    expect(output.string).to eq("""
 --- --- ---
| 1 | 2 | 3 |
 --- --- ---
| 4 | 5 | 6 |
 --- --- ---
| 7 | 8 | 9 |
 --- --- ---""")
  end

end
