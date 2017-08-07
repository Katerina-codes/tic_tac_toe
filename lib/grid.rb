class Grid

  def draw_grid
    [["| 1 ", "| 2 |", " 3 |",], ["| 4 ", "| 5 |" , " 6 |"], ["| 7 ", "| 8 |", " 9 |"]]
  end

  def place_a_move(current_grid, move, mark)
    move_part_1 = move[0]
    move_part_2 = move[1]
    current_grid[move_part_1][move_part_2] = mark
    current_grid
  end

  def is_move_unique?(move, current_grid)
    move_part_1 = move[0]
    move_part_2 = move[1]
    !current_grid[move_part_1][move_part_2].include?("X") && !current_grid[move_part_1][move_part_2].include?("O")
  end

  def get_available_moves(current_grid)
    current_grid = current_grid.flatten
    available_move_indexes = (0..current_grid.length-1).select { |index| !current_grid[index].include?("X") && !current_grid[index].include?("O") }
    available_move_indexes.map { |element| element += 1 }
  end

  def get_marks_in_a_row(row, mark)
    count = 0
    row.each do |value|
      if value.include?(mark)
        count +=1
      end
    end
    count
  end

  def get_unmarked_positions_in_a_row(row)
    count = 0
    row.each do |value|
      if !value.include?("X") && !value.include?("O")
        count +=1
      end
    end
    count
  end

  def row_has_three_marks?(current_grid, player_mark)
    row_one = current_grid[0][0].include?(player_mark) && current_grid[0][1].include?(player_mark) && current_grid[0][2].include?(player_mark)
    row_two = current_grid[1][0].include?(player_mark) && current_grid[1][1].include?(player_mark) && current_grid[1][2].include?(player_mark)
    row_three = current_grid[2][0].include?(player_mark) && current_grid[2][1].include?(player_mark) && current_grid[2][2].include?(player_mark)
    row_one == true || row_two == true || row_three == true
  end

  def column_has_three_marks?(current_grid, player_mark)
    column_one = current_grid[0][0].include?(player_mark) && current_grid[1][0].include?(player_mark) && current_grid[2][0].include?(player_mark)
    column_two = current_grid[0][1].include?(player_mark) && current_grid[1][1].include?(player_mark) && current_grid[2][1].include?(player_mark)
    column_three = current_grid[0][2].include?(player_mark) && current_grid[1][2].include?(player_mark) && current_grid[2][2].include?(player_mark)

    column_one == true || column_two == true || column_three == true
  end

  def diagonal_has_three_marks?(current_grid, player_mark)
    diagonal_one = current_grid[0][0].include?(player_mark) && current_grid[1][1].include?(player_mark) && current_grid[2][2].include?(player_mark)
    diagonal_two = current_grid[0][2].include?(player_mark) && current_grid[1][1].include?(player_mark) && current_grid[2][0].include?(player_mark)
    diagonal_one == true || diagonal_two == true
  end

end
