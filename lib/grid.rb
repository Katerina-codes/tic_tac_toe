class Grid

  def draw_grid
    (1..9).to_a
  end

  def place_a_move(current_grid, move, mark)
    current_grid[move] = mark
    current_grid
  end

  def move_unique?(move, current_grid)
    current_grid[move] != "X" && current_grid[move] != "O"
  end

  def move_valid?(move)
    move > 0 && move < 10
  end

  def get_available_moves(current_grid)
    current_grid = current_grid.flatten
    available_move_indexes = (0..current_grid.length-1).select { |index| current_grid[index] != "X" && current_grid[index] != "O" }
    available_move_indexes.map { |element| element += 1 }
  end

  def three_marks_in_a_row?(grid, line, mark)
    line.all? { |element| element == mark }
  end

  def row_win?(current_grid, player_mark)
    rows = rows(current_grid)
    rows.any? do |row|
      three_marks_in_a_row?(current_grid, row, player_mark)
    end
  end

  def column_win?(current_grid, player_mark)
    columns = rows(current_grid).transpose
    columns.any? do |column|
      three_marks_in_a_row?(current_grid, column, player_mark)
    end
  end

  def rows(current_grid)
    current_grid.each_slice(3).to_a
  end

  def diagonal_win?(current_grid, player_mark)
    rows = rows(current_grid)
    diagonal_one = rows.each_with_index.map { |line, index| line[index] }
    diagonal_two = rows.reverse.each_with_index.map { |line, index| line[index] }
    three_marks_in_a_row?(current_grid, diagonal_one, player_mark) || three_marks_in_a_row?(current_grid, diagonal_two, player_mark)
  end

  def game_over?(current_grid, player_mark)
    row_win?(current_grid, player_mark) || column_win?(current_grid, player_mark) || diagonal_win?(current_grid, player_mark)
  end

end
