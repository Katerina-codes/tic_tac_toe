class Grid

  def draw_grid
    [["| 1 |", "| 2 |", "| 3 |",], ["| 4 |", "| 5 |" , "| 6 |"], ["| 7 |", "| 8 |", "| 9 |"]]
  end

  def place_a_move(current_grid, move)
    first_position = move[0]
    second_position = move[1]
    current_grid[first_position][second_position] = "| X |"
    current_grid
  end

end
