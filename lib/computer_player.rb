class ComputerPlayer

  def play_move(move_sequences, player_mark, current_grid)
    possible_moves = (1..9).to_a
    corner_moves = [1, 3, 7, 9]
    grid = Grid.new
    if grid.get_available_moves(current_grid).count == 9 || grid.get_available_moves(current_grid).count == 8 && grid.get_available_moves(current_grid).include?(5)
      5
    elsif possible_moves.include?(block_opponent_win(move_sequences, player_mark))
      block_opponent_win(move_sequences, player_mark)
    elsif
       possible_moves.include?(play_winning_move(move_sequences, player_mark))
       play_winning_move(move_sequences, player_mark)
    else
      corner_moves.sample
    end
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
    if player_mark == "X"
      opponent_mark = "O"
    else
      opponent_mark = "X"
    end

    sequence_with_blocking_move = move_sequences.select do |sequence|
      sequence.count(opponent_mark) == 2 && !sequence.include?(player_mark)
    end
    winning_move = sequence_with_blocking_move.flatten.select { |value| value != opponent_mark }.join.to_i
  end

  def play_first_move(winning_sequence)
    5
  end

end
