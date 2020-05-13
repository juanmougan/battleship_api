module GameEngine
  def self.valid_move?(before : Board, after : Board)
    differences = 0
    10.times { |i|
      10.times { |j|
        differences += 1 unless before.cells[i][j].class == after.cells[i][j].class
      }
    }
    differences == 1
  end
end
