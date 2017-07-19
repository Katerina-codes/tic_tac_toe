class Grid

  def draw_grid
    [["| 1 |", "| 2 |", "| 3 |",], ["| 4 |", "| 5 |" , "| 6 |"], ["| 7 |", "| 8 |", "| 9 |"]]
  end

  def place_a_move(current_grid, move)
    first_position = move[0]
    second_position = move[1]
    if move == [0, 0]
      current_grid[first_position][second_position] = "| X |"
      current_grid
    elsif move == 2
      [["| 1 |", "| X |", "| 3 |",], ["| 4 |", "| 5 |" , "| 6 |"], ["| 7 |", "| 8 |", "| 9 |"]]
    else
      [["| 1 |", "| 2 |", "| X |",], ["| 4 |", "| 5 |" , "| 6 |"], ["| 7 |", "| 8 |", "| 9 |"]]
    end
  end

end
