require "uuid"

class Game
  # def initialize(player_1_name : String, player_1_board : Array(JSON::Any), url : String)

  BOARD_SIZE = 10

  property id : UUID
  property player_1 : Player
  property player_2 : Player
  property next_turn : Player
  property status : String # TODO refactor to a type
  property shareable_link : String

  def initialize(player_1_name : String, player_1_board : Array(Array(String)), url : String)
    @id = UUID.random
    @player_1 = Player.new(player_1_name, player_1_board)
    @player_2 = Player.no_one
    @next_turn = @player_1
    @status = "CREATED" # TODO either an Enum or polynomic objects here instead
    @shareable_link = shorten_url("#{url}/#{id}".to_s)
  end

  def edit(player_2_name : String, player_2_board : Array(Array(String)))
    @player_2 = Player.new(player_2_name, player_2_board)
  end

  def shorten_url(url)
    UrlShortener::Shortener
      .from_url(url)
      .shorten
  end
end
