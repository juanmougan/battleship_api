require "grip"
require "uuid"
require "url-shortener"

def base_url
  ENV["API_BASE_URL"] ||= "http://localhost:3000"
end

def shorten_url(url)
  UrlShortener::Shortener
    .from_url(url)
    .shorten
end

class Index < Grip::Controller::Http
  def get(context)
    json(
      context,
      {
        "message" => "Welcome!",
      }
    )
  end
end

class Games < Grip::Controller::Http
  def post(context)
    params = json(context)
    #puts "Got this JSON: #{params}"
    player_name = params["player_name"].to_s
    #board = params["board"].as(Array(Array(JSON::Any)))
    #board = params["board"]

    #board = Array(Array(String)).from_json(params["board"])
    #row_str = Array(String).from_json(row.to_s)
    board = Array(Array(String)).from_json(params["board"].to_s)

    #board = params["board"].as(Array(Array(String)))
    #puts "Board class #{board.class}"
    #puts "Board [0] class #{boardJson[0].class}"
    shots = params["board"] # TODO empty array instead
    game_id = UUID.random.to_s
    url = "#{base_url}/games/#{game_id}".to_s
    game = Game.new(player_name, board, url)
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
        "shareable_link": shorten_url("#{base_url}/games/#{game_id}"),
      }
    )
  end

  def patch(context)
    url_params = url(context)
    body_params = json(context)
    game_id = url_params["game_id"]
    player_name = body_params["player_name"]
    board = "TODO should be held in the Game object" # TODO add types here
    player1_id = "TODO this should be held in the Game object"
    shots = "TODO" # TODO new array
    json(
      context,
      {
        "id":       url_params["game_id"],
        "player_1": {
          "id":    player1_id,
          "board": "TODO board",
          "shots": "TODO shots",
        },
        "player_2": {
          "id":    UUID.random.to_s,
          "board": "TODO board",
          "shots": "TODO shots",
        },
        "status": "CREATED", # TODO: do not hardcode. Use an Enum?
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
