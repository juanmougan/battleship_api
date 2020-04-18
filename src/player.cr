require "json"

class Player
  property id : UUID
  property name : String
  property board : Board
  property shots : Board

  def initialize(name : String, board : Array(Array(String)))
    puts "Creating Player with name: #{name} and board: #{board}"
    @id = UUID.random
    @name = name
    @board = Board.new(board)
    @shots = Board.new
  end

  def initialize
    @id = UUID.random
    @name = ""
    @board = Board.new
    @shots = Board.new
  end
end
