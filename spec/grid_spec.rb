require 'grid'

RSpec.describe Grid do

  let(:grid) { Grid.new }
  let(:unmarked_grid) { [["| 1 ", "| 2 |", " 3 |"], ["| 4 ", "| 5 |" , " 6 |"], ["| 7 ", "| 8 |", " 9 |"]] }

  context "Creates grid" do
    it "draws an array of 3 arrays with numbers 1 - 9" do
      expect(grid.draw_grid).to eq(unmarked_grid)
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
      expect(grid.move_unique?([0, 0], unmarked_grid)).to eq(true)
    end

    it "returns false if move is not unique" do
      current_grid = [["| X ", "| 2 |", " 3 |"], ["| 4 ", "| 5 |" , " 6 |"], ["| 7 ", "| 8 |", " 9 |"]]
      expect(grid.move_unique?([0, 0], current_grid)).to eq(false)
    end

    it "returns true if move is unique and move is 2" do
      current_grid = [["| X ", "| 2 |", " 3 |"], ["| 4 ", "| 5 |" , " 6 |"], ["| 7 ", "| 8 |", " 9 |"]]
      expect(grid.move_unique?([0, 1], current_grid)).to eq(true)
    end
  end


  context "Checks status of the grid" do
    it "returns an array where all moves are available" do
      expect(grid.get_available_moves(unmarked_grid)).to eq([1, 2, 3, 4, 5, 6, 7, 8, 9])
    end

    it "returns an array where 8 moves are available" do
      current_grid = [["| X ", "| 2 |", " 3 |"], ["| 4 ", "| 5 |" , " 6 |"], ["| 7 ", "| 8 |", " 9 |"]]
      expect(grid.get_available_moves(current_grid)).to eq([2, 3, 4, 5, 6, 7, 8, 9])
    end

    it "returns an array where 7 moves are available" do
      current_grid = [["| X ", "| O |", " 3 |"], ["| 4 ", "| 5 |" , " 6 |"], ["| 7 ", "| 8 |", " 9 |"]]
      expect(grid.get_available_moves(current_grid)).to eq([3, 4, 5, 6, 7, 8, 9])
    end

    it "returns true if any of the columns have 3 X's" do
      current_grid = [["| X ", "| O |", " X |"], ["| X ", "| O |" , " 6 |"], ["| X ", "| 8 |", " 9 |"]]
      player_mark = "X"
      expect(grid.column_win?(current_grid, player_mark)).to eq(true)
    end

    it "returns false if none of the columns have 3 X's" do
      current_grid = [["| X ", "| X |", " X |"], ["| O ", "| O |" , " X |"], ["| 7 ", "| 8 |", " 9 |"]]
      player_mark = "X"
      expect(grid.column_win?(current_grid, player_mark)).to eq(false)
    end

    it "returns true if any of the columns have 3 O's" do
      current_grid = [["| X ", "| O |", " X |"], ["| X ", "| O |" , " X |"], ["| 7 ", "| O |", " 9 |"]]
      player_mark = "O"
      expect(grid.column_win?(current_grid, player_mark)).to eq(true)
    end

    it "returns true if any of the diagonals include 3 O's" do
      current_grid = [["| X ", "| X |", " O |"], ["| X ", "| O |" , " 6 |"], ["| O ", "| 8 |", " 9 |"]]
      player_mark = "O"
      expect(grid.diagonal_win?(current_grid, player_mark)).to eq(true)
    end

    it "returns false if none of the diagonals include 3 O's" do
      current_grid = [["| X ", "| X |", " O |"], ["| X ", "| 5 |" , " O |"], ["| O ", "| 8 |", " 9 |"]]
      player_mark = "O"
      expect(grid.diagonal_win?(current_grid, player_mark)).to eq(false)
    end

    it "returns true if any of the diagonals include 3 X's" do
      current_grid = [["| X ", "| O |", " X |"], ["| O ", "| X |" , " O |"], ["| X ", "| 8 |", " 9 |"]]
      player_mark = "X"
      expect(grid.diagonal_win?(current_grid, player_mark)).to eq(true)
    end

    it "returns true if any rows have 3 X's" do
      current_grid = [["| X ", "| X |", " X |"], ["| O ", "| O |" , " X |"], ["| O ", "| 8 |", " 9 |"]]
      player_mark = "X"
      expect(grid.row_win?(current_grid, player_mark)).to eq(true)
    end

    it "returns false if no rows have 3 X's" do
      current_grid = [["| X ", "| O |", " X |"], ["| O ", "| X |" , " X |"], ["| O ", "| 8 |", " 9 |"]]
      player_mark = "X"
      expect(grid.row_win?(current_grid, player_mark)).to eq(false)
    end

    it "returns true if any rows have 3 O's" do
      current_grid = [["| X ", "| X |", " X |"], ["| O ", "| O |" , " O |"], ["| X ", "| 8 |", " 9 |"]]
      player_mark = "O"
      expect(grid.row_win?(current_grid, player_mark)).to eq(true)
    end
  end

end
