require_relative 'lib/game'
require_relative 'lib/input_output'
require_relative 'lib/grid'
require_relative 'lib/human_player'
require_relative 'lib/computer_player'

input_output_instance = InputOutput.new
grid_instance = Grid.new
new_game = Game.new(input_output_instance, grid_instance, HumanPlayer.new(input_output_instance, grid_instance), ComputerPlayer.new(grid_instance))
new_game.game_flow
