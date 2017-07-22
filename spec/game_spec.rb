require 'game'
require 'input_output'
require 'validator'

RSpec.describe Game do

  let(:validator) { Validator.new }
  let(:output) { StringIO.new }

  it "gets a mark choice" do
    input = StringIO.new("x")
    input_output = InputOutput.new(output, input)
    game = Game.new(input_output, validator)
    expect(game.get_player_mark).to eq('x')
  end

  it "returns mark if mark is 'x' " do
    input_output = InputOutput.new
    game = Game.new(input_output, validator)
    expect(game.get_valid_mark("x")).to eq("x")
  end

  it "returns another mark prompt if mark is not valid" do
    input = StringIO.new("x")
    input_output = InputOutput.new(output, input)
    game = Game.new(input_output, validator)
    game.get_valid_mark("z")
    expect(output.string).to include("Choose your mark, type 'X' or 'O'")
  end

  it "gets a player move" do
    input = StringIO.new("1")
    input_output = InputOutput.new(output, input)
    game = Game.new(input_output, validator)
    expect(game.get_player_move).to eq(1)
  end

  it "returns move if move is valid" do
    input_output = InputOutput.new
    game = Game.new(input_output, validator)
    expect(game.get_valid_move(1)).to eq(1)
  end

  end

end
