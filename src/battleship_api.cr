require "grip"
require "uuid"
require "url-shortener"
require "./games.cr"

def base_url
  # ENV["API_BASE_URL"] ||= "http://localhost:3000"
  ENV["API_BASE_URL"] ||= "http://10.0.2.2:3000"
end

def shorten_url(url)
  UrlShortener::Shortener
    .from_url(url)
    .shorten
end

class CustomController < Grip::Controller::Http
  @@games = Games.new
end

class Index < CustomController
  def get(context)
    json(
      context,
      {
        "message" => "Welcome!",
      }
    )
  end
end

class Games < CustomController
  def post(context)
    params = json(context)
    player_name = params["player_name"].to_s
    board = Array(Array(String)).from_json(params["board"].to_s)
    games_url = "#{base_url}/games".to_s
    game = @@games.create(player_name, board, games_url)
    json(
      context,
      {
        "id":       game.id.to_s,
        "player_1": {
          "id":    game.player_1.id.to_s,
          "name":  game.player_1.name,
          "board": game.player_1.board.to_string_cells,
          "shots": game.player_1.shots.to_string_cells,
        },
        "status":         "CREATED", # TODO: do not hardcode. Use an Enum?
        "shareable_link": game.shareable_link,
      }
    )
  end

  def patch(context)
    url_params = url(context)
    body_params = json(context)
    game_id = UUID.new(url_params["game_id"])
    player_name = body_params["player_name"].to_s
    board = Array(Array(String)).from_json(body_params["board"].to_s)
    game = @@games.update(game_id, player_name, board, "READY")
    json(
      context,
      {
        "id":       game.id.to_s,
        "player_1": {
          "id":    game.player_1.id.to_s,
          "name":  game.player_1.name,
          "board": game.player_1.board.to_string_cells,
          "shots": game.player_1.shots.to_string_cells,
        },
        "player_2": {
          "id":    game.player_2.id.to_s,
          "name":  game.player_2.name,
          "board": game.player_2.board.to_string_cells,
          "shots": game.player_2.shots.to_string_cells,
        },
        "status":         game.status,
        "shareable_link": game.shareable_link,
      }
    )
  end

  # TODO this is the only missing endpoint to implement :)
  def put(context)
    url_params = url(context)
    body_params = json(context)
    game_id = UUID.new(url_params["game_id"])
    player_id = UUID.new(url_params["player_id"])
    # game = @@games.get(game_id).get_player(player_id) # TODO filter by player id, should be 1 or 2
    shots = Array(Array(String)).from_json(body_params["shots"].to_s)
    json(
      context,
      {
        # "id": game.id.to_s,     # TODO use this instead
        "id": game_id.to_s,
        # TODO implement this on the Game
        "current_player": {
          "id":    player_id.to_s,
          "board": "TODO board",
          "shots": shots,
        },
        # TODO maybe the Player can handle this
        "shot_result": "MISSED", # TODO Enum?
        "your_turn":   false,    # Of course, you just played :)
      }
    )
  end

  def get(context)
    url_params = url(context)
    game_id = UUID.new(url_params["game_id"])
    game = @@games.get(game_id)
    # TODO create a GameStatus and nest it inside Game
    json(
      context,
      {
        "id":             game.id.to_s,
        "status":         game.status,
        "next_player_id": game.next_turn.id.to_s,
      }
    )
  end
end

class Application < Grip::Application
  def initialize
    get "/", Index
    post "/games", Games
    patch "/games/:game_id", Games
    put "/games/:game_id/players/:player_id", Games
    # TODO decide if I need "/games/:id" instead
    get "/games/:game_id/status", Games
  end
end

app = Application.new
app.run
