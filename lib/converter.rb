class Converter

  def convert_move_number(move)
    number_to_grid_position = {
      1 => [0, 0],
      2 => [0, 1],
      3 => [0, 2],
      4 => [1, 0],
      5 => [1, 1]
    }
    number_to_grid_position[move]
  end

end
