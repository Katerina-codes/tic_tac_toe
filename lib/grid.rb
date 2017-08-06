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

  def column_has_three_marks?(current_grid, player_mark)
    true
  end
end
