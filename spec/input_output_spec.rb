require 'input_output'

RSpec.describe InputOutput do

  let(:output) { StringIO.new }
  let(:input) { StringIO.new }
  let(:input_output) { InputOutput.new(output, input) }

  context "Displays grid" do

    it "displays a formatted grid of numbers 1 - 9 to the user" do
     input_output.display_grid([["| 1 ", "| 2 |", " 3 |",], ["| 4 ", "| 5 |" , " 6 |"], ["| 7 ", "| 8 |", " 9 |"]])
     expect(output.string).to eq("""
 --- --- ---
| 1 | 2 | 3 |
 --- --- ---
| 4 | 5 | 6 |
 --- --- ---
| 7 | 8 | 9 |
 --- --- ---""")
    end

    it "displays a grid with 'X' marked at position 1" do
      input_output.display_grid([["| X ", "| 2 |", " 3 |",], ["| 4 ", "| 5 |" , " 6 |"], ["| 7 ", "| 8 |", " 9 |"]])
      expect(output.string).to eq("""
 --- --- ---
| X | 2 | 3 |
 --- --- ---
| 4 | 5 | 6 |
 --- --- ---
| 7 | 8 | 9 |
 --- --- ---""")
    end

    it "displays a grid with 'X' marked at position 2" do
      input_output.display_grid([["| 1 ", "| X |", " 3 |",], ["| 4 ", "| 5 |" , " 6 |"], ["| 7 ", "| 8 |", " 9 |"]])
      expect(output.string).to eq("""
 --- --- ---
| 1 | X | 3 |
 --- --- ---
| 4 | 5 | 6 |
 --- --- ---
| 7 | 8 | 9 |
 --- --- ---""")
    end

  end

  context "Interacts with the player" do

    it "asks the player if they want to be 'X' or 'O'" do
      input_output.ask_for_mark_choice
      expect(output.string).to eq("Choose your mark, type 'X' or 'O'\n")
    end

    it "asks the player for a move" do
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
