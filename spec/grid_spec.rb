require 'grid'

RSpec.describe Grid do

  let(:grid) { Grid.new }
  let(:unmarked_grid) { [["| 1 ", "| 2 |", " 3 |",], ["| 4 ", "| 5 |" , " 6 |"], ["| 7 ", "| 8 |", " 9 |"]] }

  it "draws an array of 3 arrays with numbers 1 - 9" do
   expect(grid.draw_grid).to eq([["| 1 ", "| 2 |", " 3 |",], ["| 4 ", "| 5 |" , " 6 |"], ["| 7 ", "| 8 |", " 9 |"]])
  end

  it "marks an 'X' on the 1st position of the grid" do
    expect(grid.place_a_move(unmarked_grid, [0, 0], "| X ")).to eq([["| X ", "| 2 |", " 3 |",], ["| 4 ", "| 5 |" , " 6 |"], ["| 7 ", "| 8 |", " 9 |"]])
  end

  it "marks an 'X' on the 2nd position of the grid" do
    expect(grid.place_a_move(unmarked_grid, [0, 1], "| X |")).to eq([["| 1 ", "| X |", " 3 |",], ["| 4 ", "| 5 |" , " 6 |"], ["| 7 ", "| 8 |", " 9 |"]])
  end

  it "marks an 'X' on the 3rd position of the grid" do
    expect(grid.place_a_move(unmarked_grid, [0, 2], " X |")).to eq([["| 1 ", "| 2 |", " X |",], ["| 4 ", "| 5 |" , " 6 |"], ["| 7 ", "| 8 |", " 9 |"]])
  end

  it "marks 'O' on the 1st position of the grid" do
    expect(grid.place_a_move(unmarked_grid, [0, 0], "| O ")).to eq([["| O ", "| 2 |", " 3 |",], ["| 4 ", "| 5 |" , " 6 |"], ["| 7 ", "| 8 |", " 9 |"]])
  end

  it "Returns true if move is unique" do
    expect(grid.is_move_unique?([0, 0], [["| 1 ", "| 2 |", " 3 |",], ["| 4 ", "| 5 |" , " 6 |"], ["| 7 ", "| 8 |", " 9 |"]])).to eq(true)
  end

end
