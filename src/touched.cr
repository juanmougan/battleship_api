class Touched < Cell
  def receive_shot
    Sunk.new
  end
end
