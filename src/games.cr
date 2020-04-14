require "uuid"
require "./game.cr"

# TODO add better docs
# This acts as a pseudo on memory repository
class Games
  def initialize
    @games = {} of UUID => Game
  end

  # Creates a Game object, and adds it to the "database"
  def create(player_1_name : String, player_1_board : Array(Array(String)), url : String)
    game = Game.new(player_1_name, player_1_board, "#{base_url}/games".to_s)
    @games[game.id] = game
    @games[game.id]
  end

  def update(game_id : UUID, player_2_name : String, player_2_board : Array(Array(String)), game_status : String)
    @games[game_id].edit(player_2_name, player_2_board, game_status)
    @games[game_id]
  end

  def get(id : UUID)
    @games[id]
  end
end
