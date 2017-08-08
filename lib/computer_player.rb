class ComputerPlayer

  def play_move(move_sequences, player_mark, current_grid)
    grid = Grid.new
    possible_moves = (1..9).to_a
    corner_moves = [1, 3, 7, 9]
    available_moves = grid.get_available_moves(current_grid)
    if grid.get_available_moves(current_grid).count == 9 || grid.get_available_moves(current_grid).count == 8 && grid.get_available_moves(current_grid).include?(5)
      5
    elsif possible_moves.include?(play_winning_move(move_sequences, player_mark))
       play_winning_move(move_sequences, player_mark)
     elsif possible_moves.include?(block_opponent_win(move_sequences, player_mark))
       block_opponent_win(move_sequences, player_mark)
     elsif !(corner_moves & available_moves).empty?
      corner_moves.sample
    else
      available_moves.sample
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

  def block_possible_fork(current_grid)
    no_fork = 0
    if current_grid[0][1].include?("X") && current_grid[1][0].include?("X")
      1
    elsif current_grid[0][1].include?("X") && current_grid[1][2].include?("X")
      3
    elsif current_grid[1][2].include?("X") && current_grid[2][1].include?("X")
      9
    elsif current_grid[1][0].include?("X") && current_grid[2][1].include?("X")
      7
    elsif current_grid[0][0].include?("X") && current_grid[2][2].include?("X")
      6
    elsif current_grid[0][2].include?("X") && current_grid[2][0].include?("X")
      4
    else
      no_fork
    end
  end

end
