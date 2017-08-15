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

  def three_marks_in_a_row?(grid, array_of_value_indexes, mark)
    count = 0
    array_of_value_indexes.each do |x, y|
      if grid[x][y].include?(mark)
        count +=1
      end
    end
    count == 3
  end

  def does_any_row_have_three_marks?(current_grid, player_mark)
    row_one = [[0, 0], [0, 1], [0, 2]]
    row_two = [[1, 0], [1, 1], [1, 2]]
    row_three = [[2, 0], [2, 1], [2, 2]]
    three_marks_in_a_row?(current_grid, row_one, player_mark) || three_marks_in_a_row?(current_grid, row_two, player_mark) || three_marks_in_a_row?(current_grid, row_three, player_mark)
  end

  def does_any_column_have_three_marks?(current_grid, player_mark)
    column_one = [[0, 0], [1, 0], [2, 0]]
    column_two = [[0, 1], [1, 1], [2, 1]]
    column_three = [[0, 2], [1, 2], [2, 2]]
    three_marks_in_a_row?(current_grid, column_one, player_mark) || three_marks_in_a_row?(current_grid, column_two, player_mark) || three_marks_in_a_row?(current_grid, column_three, player_mark)
  end

  def does_either_diagonal_have_three_marks?(current_grid, player_mark)
    diagonal_one = [[0, 0], [1, 1], [2, 2]]
    diagonal_two = [[0, 2], [1, 1], [2, 0]]
    three_marks_in_a_row?(current_grid, diagonal_one, player_mark) || three_marks_in_a_row?(current_grid, diagonal_two, player_mark)
  end

end
