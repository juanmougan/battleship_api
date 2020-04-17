class Board
  property cells : Array(Array(Cell))

  def initialize
    puts "Creating Board with no params"
    @cells = fill_shots
  end

  def initialize(board : Array(Array(String)) | Nil)
    puts "Creating Board with board: #{board}"
    @cells = from_string_cells(board)
  end

  def to_json(builder : JSON::Builder)
    puts "please implement me"
  end

  def from_string_cells(board)
    # TODO maybe can be improved with symbols + polymorfism
    # maybe the symbol can be an attribute of each cells?
    cells = [] of Array(Cell)
    10.times { |i|
      row = [] of Cell
      10.times { |j|
        if board[i][j] == "SEA"
          row << Sea.new
        else
          if board[i][j] == "SHIP"
            row << Ship.new
          end
        end
      }
      cells << row
    }
    cells
  end

  def fill_shots
    board = [] of Array(Cell)
    10.times {
      row = [] of Cell
      10.times {
        row << Sea.new
      }
      board << row
    }
    board
  end
end
