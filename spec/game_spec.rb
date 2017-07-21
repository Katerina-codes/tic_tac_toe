require 'game'
require 'input_output'
require 'validator'

RSpec.describe Game do

  it "gets a mark choice" do
    input = StringIO.new("x")
    output = StringIO.new
    input_output = InputOutput.new(output, input)
    validator = Validator.new
    game = Game.new(input_output, validator)
    expect(game.get_player_mark).to eq('x')
  end

  it "returns mark if mark is 'x' " do
    input_output = InputOutput.new
    validator = Validator.new
    game = Game.new(input_output, validator)
    expect(game.get_valid_mark("x")).to eq("x")
  end

  it "returns another mark prompt if mark is not valid" do
    input = StringIO.new("x")
    output = StringIO.new
    input_output = InputOutput.new(output, input)
    validator = Validator.new
    game = Game.new(input_output, validator)
    game.get_valid_mark("z")
    expect(output.string).to include("Choose your mark, type 'X' or 'O'")
  end

end
