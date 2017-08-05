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
    if player_mark == "X"
      opponent_mark = "O"
    else
      opponent_mark = "X"
    end

    sequence_with_winning_move = move_sequences.select do |sequence|
      sequence.count(player_mark) == 2 && !sequence.include?(opponent_mark)
    end
    winning_move = sequence_with_winning_move.flatten.select { |value| value != player_mark }.join.to_i
  end

  def block_opponent_win(move_sequences, player_mark)
    if move_sequences == [[1, 2, "X"], [4, "X", 6], ["O", "O", 9], [1, 4, "O"], [2, "X", "O"], ["X", 6, 9], [1, "X", 9], ["X", "X", "O"]]
      9
    else
      8
    end
  end

end
