require "json"

class Player
  
  property id : UUID
  property name : String
  #property board : Array(Array(String))
  #property board : Array(Array(JSON::Any))
  property board
  property shots : Array(Array(String))
  #property shots : Array(Array(JSON::Any))

  #def initialize(name : String, board : Array(Array(JSON::Any)))
  def initialize(name : String, board : Array(Array(String)))
    @id = UUID.random
    @name = name
    @board = board
    @shots = fill_shots
  end

  # TODO use a loop
  def fill_shots
    [
      ["SEA","SEA","SEA","SEA","SEA","SEA","SEA","SEA","SEA","SEA"],
      ["SEA","SEA","SEA","SEA","SEA","SEA","SEA","SEA","SEA","SEA"],
      ["SEA","SEA","SEA","SEA","SEA","SEA","SEA","SEA","SEA","SEA"],
      ["SEA","SEA","SEA","SEA","SEA","SEA","SEA","SEA","SEA","SEA"],
      ["SEA","SEA","SEA","SEA","SEA","SEA","SEA","SEA","SEA","SEA"],
      ["SEA","SEA","SEA","SEA","SEA","SEA","SEA","SEA","SEA","SEA"],
      ["SEA","SEA","SEA","SEA","SEA","SEA","SEA","SEA","SEA","SEA"],
      ["SEA","SEA","SEA","SEA","SEA","SEA","SEA","SEA","SEA","SEA"],
      ["SEA","SEA","SEA","SEA","SEA","SEA","SEA","SEA","SEA","SEA"],
      ["SEA","SEA","SEA","SEA","SEA","SEA","SEA","SEA","SEA","SEA"]
  ]
  end

  #def to_json(json : JSON::Builder)
  #  json.object do
  #    json.field "id", self.id
  #    json.field "name", self.name
  #    json.field "board", self.board
  #    json.field "shots", self.shots
  #  end
  #end
end
