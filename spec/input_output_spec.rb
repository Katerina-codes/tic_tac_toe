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
 --- --- ---\n""")
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
 --- --- ---\n""")
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
 --- --- ---\n""")
    end
  end

  context "Interacts with the player" do
    it "asks the player if they want to be 'X' or 'O'" do
      input_output.ask_for_mark_choice
      expect(output.string).to eq("Choose your mark, type 'X' or 'O'\n")
    end

    it "gets 'X' from a player" do
      input = StringIO.new("X")
      input_output = InputOutput.new(output, input)
      expect(input_output.get_mark_choice).to eq("X")
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

    it "displays an error message if move is invalid" do
      input_output.display_invalid_move_error
      expect(output.string).to eq("This move is invalid. Please enter another one\n")
    end

    it "asks the player which game mode they would like" do
      input_output.ask_for_game_mode
      expect(output.string).to eq("Please choose a mode:\nEnter '1' for human vs human\nEnter '2' for human vs computer\n")
    end

    it "gets the player's game mode choice" do
      input = StringIO.new("1")
      input_output = InputOutput.new(output, input)
      expect(input_output.get_game_mode).to eq(1)
    end

    it "announces player 1 has won" do
      input_output.display_player_one_wins
      expect(output.string).to eq("Game over. Player 1 wins!\n")
    end

    it "announces player 2 has won" do
      input_output.display_player_two_wins
      expect(output.string).to eq("Game over. Player 2 wins!\n")
    end

    it "announces game is tied" do
      input_output.display_game_tie
      expect(output.string).to eq("Game over. It's a tie!\n")
    end

    it "Returns 1 if a valid game mode is entered" do
      input = StringIO.new("1")
      input_output = InputOutput.new(output, input)
      expect(input_output.get_valid_game_mode_input).to eq(1)
    end

    it "Returns 2 if a valid game mode is entered" do
      input = StringIO.new("2")
      input_output = InputOutput.new(output, input)
      expect(input_output.get_valid_game_mode_input).to eq(2)
    end

    it "returns 'That game mode is invalid. Please enter 1 or 2.' if input is not valid" do
      input = StringIO.new("3")
      input_output = InputOutput.new(output, input)
      input_output.get_valid_game_mode_input
      expect(output.string).to eq("That game mode is invalid. Please enter 1 or 2.\n")
    end
  end

end
