require 'grid'

RSpec.describe Grid do

  let(:grid) { Grid.new }
  let(:unmarked_grid) { [["| 1 ", "| 2 |", " 3 |"], ["| 4 ", "| 5 |" , " 6 |"], ["| 7 ", "| 8 |", " 9 |"]] }

  context "Creates grid" do
    it "draws an array of 3 arrays with numbers 1 - 9" do
      expect(grid.draw_grid).to eq([["| 1 ", "| 2 |", " 3 |"], ["| 4 ", "| 5 |" , " 6 |"], ["| 7 ", "| 8 |", " 9 |"]])
    end
  end

  context "Validates player's move" do
    it "returns true if 1 is entered" do
      expect(grid.move_valid?(1)).to eq(true)
    end

    it "returns false if 10 is entered" do
      expect(grid.move_valid?(10)).to eq(false)
    end

    it "returns true if 2 is entered" do
      expect(grid.move_valid?(2)).to eq(true)
    end
  end

  context "Updates grid" do
    it "marks an 'X' on the 1st position of the grid" do
      expect(grid.place_a_move(unmarked_grid, [0, 0], "| X ")).to eq([["| X ", "| 2 |", " 3 |"], ["| 4 ", "| 5 |" , " 6 |"], ["| 7 ", "| 8 |", " 9 |"]])
    end

    it "marks an 'X' on the 2nd position of the grid" do
      expect(grid.place_a_move(unmarked_grid, [0, 1], "| X |")).to eq([["| 1 ", "| X |", " 3 |"], ["| 4 ", "| 5 |" , " 6 |"], ["| 7 ", "| 8 |", " 9 |"]])
    end

    it "marks an 'X' on the 3rd position of the grid" do
      expect(grid.place_a_move(unmarked_grid, [0, 2], " X |")).to eq([["| 1 ", "| 2 |", " X |"], ["| 4 ", "| 5 |" , " 6 |"], ["| 7 ", "| 8 |", " 9 |"]])
    end

    it "marks 'O' on the 1st position of the grid" do
      expect(grid.place_a_move(unmarked_grid, [0, 0], "| O ")).to eq([["| O ", "| 2 |", " 3 |"], ["| 4 ", "| 5 |" , " 6 |"], ["| 7 ", "| 8 |", " 9 |"]])
    end
  end

  context "Checks the status of a move" do
    it "returns true if move is unique" do
      expect(grid.is_move_unique?([0, 0], [["| 1 ", "| 2 |", " 3 |"], ["| 4 ", "| 5 |" , " 6 |"], ["| 7 ", "| 8 |", " 9 |"]])).to eq(true)
    end

    it "returns false if move is not unique" do
      expect(grid.is_move_unique?([0, 0], [["| X ", "| 2 |", " 3 |"], ["| 4 ", "| 5 |" , " 6 |"], ["| 7 ", "| 8 |", " 9 |"]])).to eq(false)
    end

    it "returns true if move is unique and move is 2" do
      expect(grid.is_move_unique?([0, 1], [["| X ", "| 2 |", " 3 |"], ["| 4 ", "| 5 |" , " 6 |"], ["| 7 ", "| 8 |", " 9 |"]])).to eq(true)
    end
  end


  context "Checks status of the grid" do
    it "returns an array where all moves are available" do
      expect(grid.get_available_moves(unmarked_grid)).to eq([1, 2, 3, 4, 5, 6, 7, 8, 9])
    end

    it "returns an array where 8 moves are available" do
      expect(grid.get_available_moves([["| X ", "| 2 |", " 3 |"], ["| 4 ", "| 5 |" , " 6 |"], ["| 7 ", "| 8 |", " 9 |"]])).to eq([2, 3, 4, 5, 6, 7, 8, 9])
    end

    it "returns an array where 7 moves are available" do
      expect(grid.get_available_moves([["| X ", "| O |", " 3 |"], ["| 4 ", "| 5 |" , " 6 |"], ["| 7 ", "| 8 |", " 9 |"]])).to eq([3, 4, 5, 6, 7, 8, 9])
    end

    it "returns true if any of the columns have 3 X's" do
      current_grid = [["| X ", "| O |", " X |"], ["| X ", "| O |" , " 6 |"], ["| X ", "| 8 |", " 9 |"]]
      expect(grid.does_any_column_have_three_marks?(current_grid, "X")).to eq(true)
    end

    it "returns false if none of the columns have 3 X's" do
      current_grid = [["| X ", "| X |", " X |"], ["| O ", "| O |" , " X |"], ["| 7 ", "| 8 |", " 9 |"]]
      expect(grid.does_any_column_have_three_marks?(current_grid, "X")).to eq(false)
    end

    it "returns true if any of the columns have 3 O's" do
      current_grid = [["| X ", "| O |", " X |"], ["| X ", "| O |" , " X |"], ["| 7 ", "| O |", " 9 |"]]
      expect(grid.does_any_column_have_three_marks?(current_grid, "O")).to eq(true)
    end

    it "returns true if any of the diagonals include 3 O's" do
      current_grid = [["| X ", "| X |", " O |"], ["| X ", "| O |" , " 6 |"], ["| O ", "| 8 |", " 9 |"]]
      expect(grid.does_either_diagonal_have_three_marks?(current_grid, "O")).to eq(true)
    end

    it "returns false if none of the diagonals include 3 O's" do
      current_grid = [["| X ", "| X |", " O |"], ["| X ", "| 5 |" , " O |"], ["| O ", "| 8 |", " 9 |"]]
      expect(grid.does_either_diagonal_have_three_marks?(current_grid, "O")).to eq(false)
    end

    it "returns true if any of the diagonals include 3 X's" do
      current_grid = [["| X ", "| O |", " X |"], ["| O ", "| X |" , " O |"], ["| X ", "| 8 |", " 9 |"]]
      expect(grid.does_either_diagonal_have_three_marks?(current_grid, "X")).to eq(true)
    end

    it "returns true if any rows have 3 X's" do
      current_grid = [["| X ", "| X |", " X |"], ["| O ", "| O |" , " X |"], ["| O ", "| 8 |", " 9 |"]]
      expect(grid.does_any_row_have_three_marks?(current_grid, "X")).to eq(true)
    end

    it "returns false if no rows have 3 X's" do
      current_grid = [["| X ", "| O |", " X |"], ["| O ", "| X |" , " X |"], ["| O ", "| 8 |", " 9 |"]]
      expect(grid.does_any_row_have_three_marks?(current_grid, "X")).to eq(false)
    end

    it "returns true if any rows have 3 O's" do
      current_grid = [["| X ", "| X |", " X |"], ["| O ", "| O |" , " O |"], ["| X ", "| 8 |", " 9 |"]]
      expect(grid.does_any_row_have_three_marks?(current_grid, "O")).to eq(true)
    end
  end

end
