require "uuid"

class Game
  #def initialize(player_1_name : String, player_1_board : Array(JSON::Any), url : String)
  
  BOARD_SIZE = 10

  property id : UUID
  property player_1 : Player
  property status : String      # TODO refactor to a type
  property shareable_link : String
  
  def initialize(player_1_name : String, player_1_board : Array(Array(String)), url : String)
  #def initialize(player_1_name : String, player_1_board : Array(Array(JSON::Any)), url : String)
    @id = UUID.random
    @player_1 = Player.new(player_1_name, player_1_board)
    @status = "CREATED"     # TODO either an Enum or polynomic objects here instead
    @shareable_link = shorten_url(url)
  end
  
  def shorten_url(url)
    UrlShortener::Shortener
      .from_url(url)
      .shorten
  end
end