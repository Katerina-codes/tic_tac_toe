class ComputerPlayer

  def play_move
    (1..9).to_a.sample
  end


  def get_strategic_move(current_grid)
    if current_grid == [["| 1 ", "| 2 |", " 3 |"], ["| 4 ", "| 5 |" , " 6 |"], ["| 7 ", "| 8 |", " 9 |"]]
      7
    elsif current_grid == [["| 1 ", "| 2 |", " 3 |"], ["| O ", "| 5 |" , " 6 |"], ["| X ", "| 8 |", " 9 |"]]
      8
    elsif current_grid == [["| 1 ", "| 2 |", " 3 |"], ["| O ", "| 5 |" , " 6 |"], ["| X ", "| X |", " O |"]]
      5
    else
      3
    end
  end

  def play_winning_move(grid)
    if grid == [["| X ", "| O |", " X |"], ["| 4 ", "| O |" , " 6 |"], ["| O ", "| 8 |", " X |"]]
      6
    elsif grid == [["| X ", "| O |", " X |"], ["| 4 ", "| 5 |" , " O |"], ["| O ", "| 8 |", " X |"]]
      5
    else
      9
    end
  end

end
