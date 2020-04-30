require "uuid"

class Game
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
    @player_2 = Player.new
    @next_turn = @player_1
    @status = "CREATED" # TODO either an Enum or polynomic objects here instead
    # @shareable_link = shorten_url("#{url}/#{id}".to_s)
    @shareable_link = "#{url}/#{id}".to_s
  end

  def edit(player_2_name : String, player_2_board : Array(Array(String)), game_status : String)
    @player_2 = Player.new(player_2_name, player_2_board)
    self.status = game_status
  end

  def get_player(player_id)
    case player_id
    when @player_1.id
      return @player_1
    when @player_2.id
      return @player_2
    else
      raise Exception.new("Player with ID: #{player_id} not found!") # TODO throw an Error and handle it on the API, return 404 there
    end
  end

  def shoot(player_id, shots)
    # TODO verify game status in [READY, IN_PROGRESS]
    player = get_player(player_id)
    # Validation!
    # Array(Array(String)).from_json(params["board"].to_s)
    player.shots = Board.new(shots)
    puts "Player shots after shot"
    puts player.shots.to_string_cells
  end

  def current_player
    # TODO implement
    @player_1
  end

  def next_player
    # TODO implement
    @player_2
  end

  def shorten_url(url)
    UrlShortener::Shortener
      .from_url(url)
      .shorten
  end
end
