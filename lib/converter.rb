class Converter

  def convert_move_number(move)
    move -= 1
  end

  def get_mark_template(move, mark)
    if move == 1 || move == 4 || move == 7
      "| #{mark} "
    elsif move == 2 || move == 5 || move == 8
      "| #{mark} |"
    else
      " #{mark} |"
    end
  end

end
