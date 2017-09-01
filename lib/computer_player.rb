class ComputerPlayer

  POSSIBLE_MOVES = (1..9).to_a

  def initialize(grid)
    @grid = grid
  end

  def get_valid_move(current_grid, move_sequences, player_mark, opponent_mark, converter_instance)
    move = play_move(move_sequences, player_mark, opponent_mark, current_grid)
    converted_move = converter_instance.convert_move_number(move)
    until @grid.move_valid?(move) && @grid.move_unique?(converted_move, current_grid)
      move = play_move(move_sequences, player_mark, opponent_mark, current_grid)
      converted_move = converter_instance.convert_move_number(move)
    end
    move
  end

  private

  def play_move(move_sequences, player_mark, opponent_mark, current_grid)
    corner_moves = [1, 3, 7, 9]
    available_moves = @grid.get_available_moves(current_grid)
    if @grid.get_available_moves(current_grid).count == 9 || @grid.get_available_moves(current_grid).count == 8 && @grid.get_available_moves(current_grid).include?(5)
      play_centre
    elsif POSSIBLE_MOVES.include?(play_winning_move(move_sequences, player_mark, opponent_mark))
       play_winning_move(move_sequences, player_mark, opponent_mark)
    elsif POSSIBLE_MOVES.include?(move_to_block_opponent_win(move_sequences, player_mark, opponent_mark))
      move_to_block_opponent_win(move_sequences, player_mark, opponent_mark)
    elsif POSSIBLE_MOVES.include?(check_for_fork(current_grid, opponent_mark))
      check_for_fork(current_grid, opponent_mark)
     elsif !(corner_moves & available_moves).empty?
      corner_moves.sample
    else
      available_moves.sample
    end
  end

  def get_sequence_with_two_player_marks(move_sequences, player_mark)
    move_sequences.select do |sequence|
      sequence.count(player_mark) == 2 && POSSIBLE_MOVES.include?((POSSIBLE_MOVES & sequence).join.to_i)
    end
  end

  def play_winning_move(move_sequences, player_mark, opponent_mark)
    sequence_with_winning_move = get_sequence_with_two_player_marks(move_sequences, player_mark)
    sequence_with_winning_move.flatten.select { |value| value != player_mark }.join.to_i
  end

  def move_to_block_opponent_win(move_sequences, player_mark, opponent_mark)
    sequence_with_blocking_move = get_sequence_with_two_player_marks(move_sequences, opponent_mark)
    sequence_with_blocking_move.flatten.select { |value| value != opponent_mark }.join.to_i
  end

  def move_to_block_fork(current_grid, opponent_mark, opponent_mark_one, opponent_mark_two, number)
    current_grid[opponent_mark_one] == opponent_mark && current_grid[opponent_mark_two] == opponent_mark && @grid.get_available_moves(current_grid).include?(number)
  end

 def possible_fork?(current_grid, opponent_mark, mark_indexes, number)
    opponent_mark_one = mark_indexes[0]
    opponent_mark_two = mark_indexes[1]
    move_to_block_fork(current_grid, opponent_mark, opponent_mark_one, opponent_mark_two, number)
  end

  def check_for_fork(current_grid, opponent_mark)
    no_fork = 0
    if possible_fork?(current_grid, opponent_mark, [1, 3], 1)
      1
    elsif possible_fork?(current_grid, opponent_mark, [1, 5], 3)
      3
    elsif possible_fork?(current_grid, opponent_mark, [5, 7], 9)
      9
    elsif possible_fork?(current_grid, opponent_mark, [3, 7], 7)
      7
    elsif possible_fork?(current_grid, opponent_mark, [0, 8], 6)
      6
    elsif possible_fork?(current_grid, opponent_mark, [2, 6], 4)
      4
    else
      no_fork
    end
  end

  def play_centre
    5
  end

end
