require 'input_output'

RSpec.describe InputOutput do

  context "grid" do

    it "displays a formatted grid of numbers 1 - 9 to the user" do
     input_output = InputOutput.new
     expect(input_output.display_grid([["| 1 |", "| 2 |", "| 3 |",], ["| 4 |", "| 5 |" , "| 6 |"], ["| 7 |", "| 8 |", "| 9 |"]])).to eq("""
 --- --- ---
| 1 | 2 | 3 |
 --- --- ---
| 4 | 5 | 6 |
 --- --- ---
| 7 | 8 | 9 |
 --- --- ---""")
    end

    it "displays a grid with 'X' marked at position 1" do
      input_output = InputOutput.new
      expect(input_output.display_grid([["| X |", "| 2 |", "| 3 |",], ["| 4 |", "| 5 |" , "| 6 |"], ["| 7 |", "| 8 |", "| 9 |"]])).to eq("""
 --- --- ---
| X | 2 | 3 |
 --- --- ---
| 4 | 5 | 6 |
 --- --- ---
| 7 | 8 | 9 |
 --- --- ---""")
    end

    it "displays a grid with 'X' marked at position 2" do
      input_output = InputOutput.new
      expect(input_output.display_grid([["| 1 |", "| X |", "| 3 |",], ["| 4 |", "| 5 |" , "| 6 |"], ["| 7 |", "| 8 |", "| 9 |"]])).to eq("""
 --- --- ---
| 1 | X | 3 |
 --- --- ---
| 4 | 5 | 6 |
 --- --- ---
| 7 | 8 | 9 |
 --- --- ---""")
    end

  end

  context "interacts with the player" do

    it "asks the player for a move" do
      output = StringIO.new
      input_output = InputOutput.new(output)
      input_output.ask_for_move
      expect(output.string).to eq("Time to place your mark! Please choose a number from 1 - 9\n")
    end

    it "gets a move from a player" do
      input = StringIO.new("1")
      input_output = InputOutput.new(output, input)
      expect(input_output.get_move).to eq(1)
    end

  end

end
