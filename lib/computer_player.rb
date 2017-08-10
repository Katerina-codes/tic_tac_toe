class ComputerPlayer

  def initialize(grid)
    @grid = grid
  end

  def get_opponent_mark(player_mark)
    if player_mark == "X"
      opponent_mark = "O"
    else
      opponent_mark = "X"
    end
  end

  def get_valid_move(current_grid, move_sequences, player_mark, converter_instance)
    move = play_move(move_sequences, player_mark, current_grid)
    converted_move = converter_instance.convert_move_number(move)
    until @grid.move_valid?(move) && @grid.is_move_unique?(converted_move, current_grid)
      move = play_move(move_sequences, player_mark, current_grid)
      converted_move = converter_instance.convert_move_number(move)
    end
    move
  end

  def play_move(move_sequences, player_mark, current_grid)
    opponent_mark = get_opponent_mark(player_mark)
    possible_moves = (1..9).to_a
    corner_moves = [1, 3, 7, 9]
    available_moves = @grid.get_available_moves(current_grid)
    if @grid.get_available_moves(current_grid).count == 9 || @grid.get_available_moves(current_grid).count == 8 && @grid.get_available_moves(current_grid).include?(5)
      5
    elsif possible_moves.include?(play_winning_move(move_sequences, player_mark, opponent_mark))
       play_winning_move(move_sequences, player_mark, opponent_mark)
    elsif possible_moves.include?(block_opponent_win(move_sequences, player_mark, opponent_mark))
      block_opponent_win(move_sequences, player_mark, opponent_mark)
    elsif possible_moves.include?(block_possible_fork(current_grid, opponent_mark))
      block_possible_fork(current_grid, opponent_mark)
     elsif !(corner_moves & available_moves).empty?
      corner_moves.sample
    else
      available_moves.sample
    end
  end

  def get_sequence_with_two_player_marks(move_sequences, player_mark)
    possible_moves = (1..9).to_a
    seq = move_sequences.select do |sequence|
      sequence.count(player_mark) == 2 && possible_moves.include?((possible_moves & sequence).join.to_i)
    end
  end

  def play_winning_move(move_sequences, player_mark, opponent_mark)
    sequence_with_winning_move = move_sequences.select do |sequence|
      sequence.count(player_mark) == 2 && !sequence.include?(opponent_mark)
    end
    winning_move = sequence_with_winning_move.flatten.select { |value| value != player_mark }.join.to_i
  end

  def block_opponent_win(move_sequences, player_mark, opponent_mark)
    sequence_with_blocking_move = move_sequences.select do |sequence|
      sequence.count(opponent_mark) == 2 && !sequence.include?(player_mark)
    end
    winning_move = sequence_with_blocking_move.flatten.select { |value| value != opponent_mark }.join.to_i
  end

  def play_first_move(winning_sequence)
    5
  end

  def block_possible_fork(current_grid, opponent_mark)
    no_fork = 0
    if current_grid[0][1].include?(opponent_mark) && current_grid[1][0].include?(opponent_mark) && @grid.get_available_moves(current_grid).include?(1)
      1
    elsif current_grid[0][1].include?(opponent_mark) && current_grid[1][2].include?(opponent_mark) && @grid.get_available_moves(current_grid).include?(3)
      3
    elsif current_grid[1][2].include?(opponent_mark) && current_grid[2][1].include?(opponent_mark) && @grid.get_available_moves(current_grid).include?(9)
      9
    elsif current_grid[1][0].include?(opponent_mark) && current_grid[2][1].include?(opponent_mark) && @grid.get_available_moves(current_grid).include?(7)
      7
    elsif current_grid[0][0].include?(opponent_mark) && current_grid[2][2].include?(opponent_mark) && @grid.get_available_moves(current_grid).include?(6)
      6
    elsif current_grid[0][2].include?(opponent_mark) && current_grid[2][0].include?(opponent_mark) && @grid.get_available_moves(current_grid).include?(4)
      4
    else
      no_fork
    end
  end

end
