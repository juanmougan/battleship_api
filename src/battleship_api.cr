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
      }
    )
  end

  # def get(context)
  #   params = url(context)
  #   json(
  #     context,
  #     {
  #       "id": params["id"]
  #     }
  #   )
  # end
end

class Application < Grip::Application
  def initialize
    get "/", Index
    resource "/games", Games
  end
end

app = Application.new
app.run
