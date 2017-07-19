require 'grid'

RSpec.describe Grid do

  it "draws an array of 3 arrays with numbers 1 - 9" do
   grid = Grid.new
   expect(grid.draw_grid).to eq([["| 1 |", "| 2 |", "| 3 |",], ["| 4 |", "| 5 |" , "| 6 |"], ["| 7 |", "| 8 |", "| 9 |"]])
  end
end
