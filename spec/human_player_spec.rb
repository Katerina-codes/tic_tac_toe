require 'human_player'
require 'input_output'

RSpec.describe HumanPlayer do

  let(:grid) { Grid.new }

  it "plays a move" do
    input = StringIO.new("1")
    output = StringIO.new
    input_output = InputOutput.new(output, input)
    human_player = HumanPlayer.new(input_output, grid)
    current_grid = [["| 1 ", "| 2 |", " 3 |"], ["| 4 ", "| 5 |" , " 6 |"], ["| 7 ", "| 8 |", " 9 |"]]
    expect(human_player.play_move("X", current_grid)).to eq(1)
  end

  context "Gets a valid move" do
    it "gets a player move" do
      input = StringIO.new("1")
      output = StringIO.new
      input_output = InputOutput.new(output, input)
      human_player = HumanPlayer.new(input_output, grid)
      converter_instance = Converter.new
      current_grid = [["| 1 ", "| 2 |", " 3 |",], ["| 4 ", "| 5 |" , " 6 |"], ["| 7 ", "| 8 |", " 9 |"]]
      expect(human_player.get_valid_move(current_grid, "X", converter_instance)).to eq(1)
    end

    it "returns move if move is valid" do
      input = StringIO.new("1")
      output = StringIO.new
      input_output = InputOutput.new(output, input)
      human_player = HumanPlayer.new(input_output, grid)
      converter_instance = Converter.new
      current_grid = [["| 1 ", "| 2 |", " 3 |",], ["| 4 ", "| 5 |" , " 6 |"], ["| 7 ", "| 8 |", " 9 |"]]
      expect(human_player.get_valid_move(current_grid, "X", converter_instance)).to eq(1)
    end

    it "displays error message and gets move until move is valid" do
      input = StringIO.new("0\n1")
      output = StringIO.new
      input_output = InputOutput.new(output, input)
      human_player = HumanPlayer.new(input_output, grid)
      converter_instance = Converter.new
      current_grid = [["| 1 ", "| 2 |", " 3 |",], ["| 4 ", "| 5 |" , " 6 |"], ["| 7 ", "| 8 |", " 9 |"]]
      human_player.get_valid_move(current_grid, "X", converter_instance)
      expect(output.string).to include("This move is invalid. Please enter another one\n")
    end

    it "displays error message if the same move is entered twice" do
      input = StringIO.new("1\n2")
      output = StringIO.new
      input_output = InputOutput.new(output, input)
      human_player = HumanPlayer.new(input_output, grid)
      converter_instance = Converter.new
      current_grid_with_mark = [["| X ", "| 2 |", " 3 |",], ["| 4 ", "| 5 |" , " 6 |"], ["| 7 ", "| 8 |", " 9 |"]]
      human_player.get_valid_move(current_grid_with_mark, "X", converter_instance)
      expect(output.string).to include("This move is invalid. Please enter another one\n")
    end
  end

end
