require "grip"
require "uuid"
require "url-shortener"
require "./games.cr"

def base_url
  ENV["API_BASE_URL"] ||= "http://localhost:3000"
end

def shorten_url(url)
  UrlShortener::Shortener
    .from_url(url)
    .shorten
end

class CustomController < Grip::Controller::Http
  @@all_games = Games.new
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
    puts "Got this JSON: #{params}"
    player_name = params["player_name"].to_s
    board = Array(Array(String)).from_json(params["board"].to_s)
    games_url = "#{base_url}/games".to_s
    puts "Will create Game with player_name: #{player_name} board: #{board} games_url: #{games_url}"
    game = @@all_games.as(Games).create(player_name, board, games_url)
    json(
      context,
      {
        "id":       game.id.to_s,
        "player_1": {
          "id":    game.player_1.id.to_s,
          "name":  game.player_1.name,
          "board": game.player_1.board,
          "shots": game.player_1.shots,
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
    game = @@all_games.as(Games).update(game_id, player_name, board)
    json(
      context,
      {
        "id":       url_params["game_id"],
        "player_1": {
          "id":    game.player_1.id.to_s,
          "name":  game.player_1.name,
          "board": game.player_1.board,
          "shots": game.player_1.shots,
        },
        "player_2": {
          "id":    game.player_2.id.to_s,
          "name":  game.player_2.name,
          "board": game.player_2.board,
          "shots": game.player_2.shots,
        },
        "status":         "READY", # TODO: do not hardcode. Use an Enum?
        "shareable_link": game.shareable_link,
      }
    )
  end

  def put(context)
    url_params = url(context)
    body_params = json(context)
    game_id = url_params["game_id"]
    player_id = url_params["player_id"]
    shots = body_params["shots"] # TODO add types here
    json(
      context,
      {
        "id":             url_params["game_id"],
        "current_player": {
          "id":    player_id,
          "board": "TODO board",
          "shots": shots,
        },
        "shot_result": "MISSED", # TODO Enum?
        "your_turn":   false,    # Of course, you just played :)
      }
    )
  end

  def get(context)
    url_params = url(context)
    puts "Got this params: #{url_params}"
    game_id = url_params["game_id"]
    # TODO create a GameStatus and nest it inside Game
    json(
      context,
      {
        "id":             game_id,
        "status":         "FINISHED",       # TODO
        "next_player_id": UUID.random.to_s, # TODO
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
