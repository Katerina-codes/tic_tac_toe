class Converter

  def convert_move_number(move)
    move_to_grid_position = {
      1 => [0, 0],
      2 => [0, 1],
      3 => [0, 2],
      4 => [1, 0],
      5 => [1, 1],
      6 => [1, 2],
      7 => [2, 0],
      8 => [2, 1],
      9 => [2, 2]
    }
    move_to_grid_position[move]
  end

  def get_mark_template(move, mark)
    if move == 1 || move == 4
      "| #{mark} "
    elsif move == 2 || move == 5
      "| #{mark} |"
    else
      " #{mark} |"
    end
  end

end
