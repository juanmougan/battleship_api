class Ship < Cell
  def receive_shot
    Touched.new
  end
end
