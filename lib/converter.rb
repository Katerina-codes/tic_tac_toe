class Converter

  def convert_move_number(move)
    if move == 1
      [0, 0]
    elsif move == 2
      [0, 1]
    else
      [0, 2]
    end
  end

end
