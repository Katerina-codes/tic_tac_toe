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

  def move_valid?(move)
    move > 0 && move < 10
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

  def grid(current_grid, row)
    grid = {
      "row one" => [current_grid[0][0], current_grid[0][1], current_grid[0][2]],
      "row two" => [current_grid[1][0], current_grid[1][1], current_grid[1][2]],
      "row three" => [current_grid[2][0], current_grid[2][1], current_grid[2][2]],
      "column one" => [current_grid[0][0], current_grid[1][0], current_grid[2][0]],
      "column two" => [current_grid[0][1], current_grid[1][1], current_grid[2][1]],
      "column three" => [current_grid[0][2], current_grid[1][2], current_grid[2][2]],
      "diagonal one" => [current_grid[0][0], current_grid[1][1], current_grid[2][2]],
      "diagonal two" => [current_grid[0][2], current_grid[1][1], current_grid[2][0]]
    }
    grid[row]
  end

  def does_any_row_have_three_marks?(current_grid, player_mark)
    row_one = grid(current_grid, "row one")
    row_one_mark_count = get_marks_in_a_row(row_one, player_mark)
    row_two = grid(current_grid, "row two")
    row_two_mark_count = get_marks_in_a_row(row_two, player_mark)
    row_three = grid(current_grid, "row three")
    row_three_mark_count = get_marks_in_a_row(row_three, player_mark)
    row_one_mark_count == 3 || row_two_mark_count == 3 || row_three_mark_count == 3
  end

  def does_any_column_have_three_marks?(current_grid, player_mark)
    column_one = grid(current_grid, "column one")
    column_one_mark_count = get_marks_in_a_row(column_one, player_mark)
    column_two = grid(current_grid, "column two")
    column_two_mark_count = get_marks_in_a_row(column_two, player_mark)
    column_three = grid(current_grid, "column three")
    column_three_mark_count = get_marks_in_a_row(column_three, player_mark)
    column_one_mark_count == 3 || column_two_mark_count == 3 || column_three == 3
  end

  def does_either_diagonal_have_three_marks?(current_grid, player_mark)
    diagonal_one = grid(current_grid, "diagonal one")
    diagonal_one_mark_count = get_marks_in_a_row(diagonal_one, player_mark)
    diagonal_two = grid(current_grid, "diagonal two")
    diagonal_two_mark_count = get_marks_in_a_row(diagonal_two, player_mark)
    diagonal_one == 3 || diagonal_two_mark_count == 3
  end

end
