class Grid

  def draw_grid
    [["| 1 |", "| 2 |", "| 3 |",], ["| 4 |", "| 5 |" , "| 6 |"], ["| 7 |", "| 8 |", "| 9 |"]]
  end

  def place_a_move(current_grid, move)
    move_part_1 = move[0]
    move_part_2 = move[1]
    current_grid[move_part_1][move_part_2] = "| X |"
    current_grid
  end

end
