require_relative 'lib/game'
require_relative 'lib/input_output'

new_game = Game.new(InputOutput.new, Validator.new)
new_game.get_player_mark
