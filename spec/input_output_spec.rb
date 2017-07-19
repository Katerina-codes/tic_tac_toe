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

  end

  context "displays intructions to the player" do

    it "asks the player for a move" do
      output = StringIO.new
      input_output = InputOutput.new(output)
      input_output.ask_for_move
      expect(output.string).to eq("Time to place your mark! Please choose a number from 1 - 9\n")
    end

  end

end
