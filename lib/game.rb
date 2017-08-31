class Game

  def initialize(input_output, grid, converter, human_player, computer_player)
    @input_output = input_output
    @grid = grid
    @converter = converter
    @human_player = human_player
    @computer_player = computer_player
  end

  def get_game_mode
    @input_output.ask_for_game_mode
    @input_output.get_valid_game_mode_input
  end

  def replay
    @input_output.ask_for_replay
    replay_choice = @input_output.get_valid_replay_decision
    if replay_choice == 1
      game_flow
    else
      replay_choice
    end
  end

  def game_flow
    player_types = {
      1 => [@human_player, @human_player],
      2 => [@human_player, @computer_player]
    }
    game_mode = get_game_mode
    current_grid = initial_grid
    p1_winning_move_sequence = [["X", "X", "X"]]
    p2_winning_move_sequence = [["O", "O", "O"]]
    p1_mark = "X"
    p2_mark = "O"
    p1_type, p2_type = player_types[game_mode]
    winning_move_sequences = [[1, 2, 3], [4, 5, 6], [7, 8, 9], [1, 4, 7], [2, 5, 8], [3, 6, 9], [1, 5, 9], [3, 5, 7]]
    until game_over?(winning_move_sequences, p1_winning_move_sequence) || game_over?(winning_move_sequences, p2_winning_move_sequence) || @grid.get_available_moves(current_grid) == []
      winning_move_sequences = player_move_flow(p1_type, p1_mark, p2_mark, winning_move_sequences, current_grid)
      if game_over?(winning_move_sequences, p1_winning_move_sequence) || @grid.get_available_moves(current_grid) == []
        @input_output.display_grid(current_grid)
      else
        @input_output.display_grid(current_grid)
        winning_move_sequences = player_move_flow(p2_type, p2_mark, p1_mark, winning_move_sequences, current_grid)
        @input_output.display_grid(current_grid)
      end
    end
    get_end_score(current_grid, p1_mark, p2_mark)
    replay
  end

  private

  def player_move_flow(player_type, player_mark, opponent_mark, winning_move_sequences, current_grid)
    if player_type == @human_player
      move = player_type.get_valid_move(current_grid, player_mark, @converter)
    else
      move = player_type.get_valid_move(current_grid, winning_move_sequences, player_mark, opponent_mark, @converter)
    end
    format_and_place_move_on_grid(player_mark, move, current_grid)
    put_mark_in_move_sequences(winning_move_sequences, move, player_mark)
  end

  def initial_grid
    new_grid = @grid.draw_grid
    @input_output.display_grid(new_grid)
    new_grid
  end

  def format_and_place_move_on_grid(mark, move, current_grid)
    converted_move = @converter.convert_move_number(move)
    @grid.place_a_move(current_grid, converted_move, mark)
  end

  def put_mark_in_move_sequences(winning_move_sequences, move, player_mark)
    winning_moves = winning_move_sequences.flatten
    index_position_of_move = (0..winning_moves.length-1).select { |value| winning_moves[value] == move }
    index_position_of_move.each { |index| winning_moves[index] = player_mark }
    winning_moves.each_slice(3).to_a
  end

  def player_wins?(current_grid, player_mark)
    @grid.row_win?(current_grid, player_mark) || @grid.column_win?(current_grid, player_mark) || @grid.diagonal_win?(current_grid, player_mark)
  end

  def game_over?(winning_move_sequences, winning_sequence)
    !(winning_move_sequences & winning_sequence).empty?
  end

  def get_end_score(current_grid, p1_mark, p2_mark)
    if player_wins?(current_grid, p1_mark)
      @input_output.display_player_one_wins
    elsif player_wins?(current_grid, p2_mark)
      @input_output.display_player_two_wins
    else
      @input_output.display_game_tie
    end
  end
end
