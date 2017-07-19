require 'grid'

RSpec.describe Grid do

  it "draws an array of 3 arrays with numbers 1 - 9" do
   grid = Grid.new
   expect(grid.draw_grid).to eq([["| 1 |", "| 2 |", "| 3 |",], ["| 4 |", "| 5 |" , "| 6 |"], ["| 7 |", "| 8 |", "| 9 |"]])
  end

  it "marks an 'X' on the 1st position of the grid" do
    grid = Grid.new
    current_grid = [["| 1 |", "| 2 |", "| 3 |",], ["| 4 |", "| 5 |" , "| 6 |"], ["| 7 |", "| 8 |", "| 9 |"]]
    expect(grid.place_a_move(current_grid, 1)).to eq([["| X |", "| 2 |", "| 3 |",], ["| 4 |", "| 5 |" , "| 6 |"], ["| 7 |", "| 8 |", "| 9 |"]])
  end

  it "marks an 'X' on the 2nd position of the grid" do
    grid = Grid.new
    current_grid = [["| 1 |", "| 2 |", "| 3 |",], ["| 4 |", "| 5 |" , "| 6 |"], ["| 7 |", "| 8 |", "| 9 |"]]
    expect(grid.place_a_move(current_grid, 2)).to eq([["| 1 |", "| X |", "| 3 |",], ["| 4 |", "| 5 |" , "| 6 |"], ["| 7 |", "| 8 |", "| 9 |"]])
  end

  it "marks an 'X' on the 3rd position of the grid" do
    grid = Grid.new
    current_grid = [["| 1 |", "| 2 |", "| 3 |",], ["| 4 |", "| 5 |" , "| 6 |"], ["| 7 |", "| 8 |", "| 9 |"]]
    expect(grid.place_a_move(current_grid, 3)).to eq([["| 1 |", "| 2 |", "| X |",], ["| 4 |", "| 5 |" , "| 6 |"], ["| 7 |", "| 8 |", "| 9 |"]])
  end

end
