require "json"

class Player
  property id : UUID
  property name : String
  property board
  property shots : Array(Array(String))

  def initialize(name : String, board : Array(Array(String)))
    @id = UUID.random
    @name = name
    @board = board
    @shots = fill_shots
  end

  # TODO use a loop
  def fill_shots
    [
      ["SEA", "SEA", "SEA", "SEA", "SEA", "SEA", "SEA", "SEA", "SEA", "SEA"],
      ["SEA", "SEA", "SEA", "SEA", "SEA", "SEA", "SEA", "SEA", "SEA", "SEA"],
      ["SEA", "SEA", "SEA", "SEA", "SEA", "SEA", "SEA", "SEA", "SEA", "SEA"],
      ["SEA", "SEA", "SEA", "SEA", "SEA", "SEA", "SEA", "SEA", "SEA", "SEA"],
      ["SEA", "SEA", "SEA", "SEA", "SEA", "SEA", "SEA", "SEA", "SEA", "SEA"],
      ["SEA", "SEA", "SEA", "SEA", "SEA", "SEA", "SEA", "SEA", "SEA", "SEA"],
      ["SEA", "SEA", "SEA", "SEA", "SEA", "SEA", "SEA", "SEA", "SEA", "SEA"],
      ["SEA", "SEA", "SEA", "SEA", "SEA", "SEA", "SEA", "SEA", "SEA", "SEA"],
      ["SEA", "SEA", "SEA", "SEA", "SEA", "SEA", "SEA", "SEA", "SEA", "SEA"],
      ["SEA", "SEA", "SEA", "SEA", "SEA", "SEA", "SEA", "SEA", "SEA", "SEA"],
    ]
  end

  # A no object
  def self.no_one
    Player.new("", [] of Array(String))
  end
end
