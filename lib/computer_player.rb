class ComputerPlayer

  def play_move
    (1..9).to_a.sample
  end


  def get_strategic_move(current_grid)
    if current_grid == [["| 1 ", "| 2 |", " 3 |"], ["| 4 ", "| 5 |" , " 6 |"], ["| 7 ", "| 8 |", " 9 |"]]
      7
    else
      8
    end
  end

end
