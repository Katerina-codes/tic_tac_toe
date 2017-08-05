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

  def play_winning_move(move_sequences, player_mark)
    sequence_with_winning_move = move_sequences.select do |sequence|
      sequence.count(player_mark) == 2 && !sequence.include?("O")
    end
    winning_move = sequence_with_winning_move.flatten.select { |value| value != "X" }.join.to_i
  end

end
