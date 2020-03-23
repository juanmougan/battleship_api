require "grip"
require "uuid"

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
    player_name = params["player_name"]
    board = params["board"] # TODO add types here
    shots = "TODO"          # TODO new array
    json(
      context,
      {
        "id":         UUID.random.to_s,
        "player1_id": UUID.random.to_s,
        "board":      board,
        "shots":      shots,
        "status":     "CREATED", # TODO: do not hardcode. Use an Enum?
      }
    )
  end

  def patch(context)
    puts "Routed to PATCH"
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
        "id":         url_params["game_id"],
        "player1_id": player1_id,
        "player2_id": UUID.random.to_s,
        "board":      board,
        "shots":      shots,
        "status":     "CREATED", # TODO: do not hardcode. Use an Enum?
      }
    )
  end
end

class Application < Grip::Application
  def initialize
    get "/", Index
    post "/games", Games
    patch "/games/:game_id", Games
  end
end

app = Application.new
app.run
